defmodule WhereAmI do
  @moduledoc """
  Command line application to POST location information to the WhereAmI Server
  """

  @doc """
  Uploads the user's approximate location to whereami.mattgowie.com

  1. Fetches the client's IP Address from icanhazip.com
  2. Does a lookup of the fetched IP Address from the IP2Location database
  3. POSTs the IP2Location.Result infomration to whereami.mattgowie.com
  """
  def main(_) do
    log "Starting WhereAmI#main..."

    ip_addr = case HTTPoison.get("icanhazip.com") do
      {:ok, %HTTPoison.Response{body: body}} -> String.trim(body)
      {_, _} -> nil
    end

    log "Found IP Address: #{ip_addr}"

    location = IP2Location.lookup(ip_addr)
    ip = location |> Map.get(:ip) |> Tuple.to_list() |> Enum.join(".")
    post_params = Map.take(location, [:county_long, :city, :region, :latitude, :longitude])
                  |> Map.put(:timestamp, :os.system_time(:second))
                  |> Map.put(:ip, ip)
    post_body = Poison.Encoder.encode(post_params, [])

    log "Uploading location information to whereami endpoint... \n Params: #{post_body}"

    HTTPoison.post "https://whereami.mattgowie.com/location", post_body, [{"Content-Type", "application/json"}]

    log "Successfully completed!"
  end

  defp log(msg) do
    IO.puts "#{DateTime.utc_now |> DateTime.to_string()} -- #{msg}"
  end
end
