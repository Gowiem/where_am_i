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
    post_body = Map.take(location, [:county_long, :city, :region, :latitude, :longitude, :ip])

    HTTPoison.post "https://whereami.mattgowie.com", post_body, [{"Content-Type", "application/json"}]
  end
end
