use Mix.Config

database_file =
  [ __DIR__, "../db/ip2location_db/IP2LOCATION-LITE-DB5.BIN" ]
    |> Path.join()
    |> Path.expand()

config :ip2location,
  database: database_file,
  pool: [ size: 5, max_overflow: 10 ]

import_config "#{Mix.env}.exs"
