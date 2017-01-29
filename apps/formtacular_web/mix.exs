defmodule FormtacularWeb.Mixfile do
  use Mix.Project

  def project do
    [app: :formtacular_web,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {FormtacularWeb, []},
     extra_applications: []]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_ecto, "~> 3.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:bugsnag, "~> 1.4-beta", override: true},
     {:cowboy, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:formtacular_store, in_umbrella: true},
     {:plugsnag, "~> 1.3-beta"}]
  end

  defp aliases do
    ["ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
