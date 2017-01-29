use Mix.Config

config :formtacular_store, FormtacularStore.Repo,
  database: "formtacular_store_prod"

config :formtacular_store, FormtacularStore.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")
