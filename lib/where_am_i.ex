defmodule WhereAmI do
  @moduledoc """
  Command line application to POST location informaation to the WhereAmI Server
  """

  @doc """
  Uploads the user's approximate location to whereami.mattgowie.com

  1. Fetches the client's IP Address from icanhazip.com
  2. Does a lookup of the fetched IP Address from the IP2Location database
  3. POSTs the IP2Location.Result infomration to whereami.mattgowie.com
  """
  def main(_) do
    ip_addr = case HTTPoison.get("icanhazip.com") do
      {:ok, %HTTPoison.Response{body: body}} -> String.trim(body)
      {_, _} -> nil
    end

    location = IP2Location.lookup(ip_addr)
    ip = location |> Map.get(:ip) |> Tuple.to_list() |> Enum.join(".")
    post_params = Map.take(location, [:county_long, :city, :region, :latitude, :longitude])
                  |> Map.put(:timestamp, :os.system_time(:second))
                  |> Map.put(:ip, ip)
    post_body = Poison.Encoder.encode(post_params, [])

    HTTPoison.post "https://whereami.mattgowie.com/location", post_body, [{"Content-Type", "application/json"}]
    IO.puts "Successfully POST'd to Location Endpoint. Params: #{post_body}"
  end
end
