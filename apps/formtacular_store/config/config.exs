# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :formtacular_store,
  ecto_repos: [FormtacularStore.Repo]

# Configure the database
config :formtacular_store, FormtacularStore.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :formtacular_store, FormtacularStore.Geo,
  adapter: FormtacularStore.Geo.FreeGeoIpAdapter

config :formtacular_store, FormtacularStore.Geo.FreeGeoIpAdapter,
  base_url: "https://freegeoip.net"

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :formtacular_store, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:formtacular_store, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

import_config "#{Mix.env}.exs"
