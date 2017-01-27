use Mix.Config

config :formtacular_store, FormtacularStore.Repo,
  database: "formtacular_store_test",
  pool: Ecto.Adapters.SQL.Sandbox
