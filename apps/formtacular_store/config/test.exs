use Mix.Config

config :formtacular_store, FormtacularStore.Repo,
  database: "formtacular_store_test",
  pool: Ecto.Adapters.SQL.Sandbox

# Configuring adapters
config :formtacular_store, FormtacularStore.Geo,
  adapter: FormtacularStore.Geo.TestIpLookupAdapter

# Configures the mailer
config :formtacular_store, FormtacularStore.Mailer,
  adapter: Bamboo.TestAdapter
