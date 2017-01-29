use Mix.Config

config :formtacular_store, FormtacularStore.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :formtacular_store, FormtacularStore.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")
