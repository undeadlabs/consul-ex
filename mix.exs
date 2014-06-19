defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [app: :consul,
     version: "0.0.1",
     elixir: "~> 0.13.3",
     config_path: "config/#{Mix.env}.exs",
     deps: deps]
  end

  def application do
    [
      applications: [:httpoison],
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
      {:httpoison, github: "edgurgel/httpoison", tag: "0.1.1"},
    ]
  end
end
