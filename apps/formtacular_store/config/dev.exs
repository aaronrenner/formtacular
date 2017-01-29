use Mix.Config

config :formtacular_store, FormtacularStore.Repo,
  database: "formtacular_store_dev"

# Configures the mailer
config :formtacular_store, FormtacularStore.Mailer,
  adapter: Bamboo.LocalAdapter
