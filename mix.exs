defmodule WhereAmI.Mixfile do
  use Mix.Project

  def project do
    [app: :where_am_i,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: WhereAmI],
     deps: deps()]
  end

  def application do
    [application: [:httpoison, :ip2location], extra_applications: [:logger]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10.0"},
      {:ip2location, github: "nazipov/ip2location-elixir"},
    ]
  end
end
