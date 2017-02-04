defmodule WhereAmI.Mixfile do
  use Mix.Project

  def project do
    [app: :where_am_i,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ip2location, github: "nazipov/ip2location-elixir"},
    ]
  end
end
