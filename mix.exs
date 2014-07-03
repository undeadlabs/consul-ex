defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [app: :consul,
     version: "0.0.1",
     elixir: "~> 0.13",
     config_path: "config/#{Mix.env}.exs",
     deps: deps]
  end

  def application do
    [
      applications: [:httpoison, :jsex],
      mod: {Consul, []},
      env: [
        host: "localhost",
        port: 8500,
      ]
    ]
  end

  defp deps do
    [
      {:jsex, "~> 2.0"},
      {:httpoison, "~> 0.3.1", github: "edgurgel/httpoison"},
    ]
  end
end
