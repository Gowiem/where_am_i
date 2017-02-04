defmodule WhereAmI do
  @moduledoc """
  Command line application to POST location informaation to the WhereAmI Server
  """

  @doc """

  """
  def main(_) do
    ip_addr = case HTTPoison.get("icanhazip.com") do
      {:ok, %HTTPoison.Response{body: body}} -> String.trim(body)
      {_, _} -> nil
    end

    location = IP2Location.lookup(String.trim(ip_addr))
    post_body = Map.take(location, [:county_long, :city, :region, :latitude, :longitude, :ip])

    HTTPoison.post "https://whereami.mattgowie.com", post_body, [{"Content-Type", "application/json"}]
  end
end
