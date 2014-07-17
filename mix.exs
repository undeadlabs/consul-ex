defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :consul,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      deps: deps,
      package: package,
      description: description
    ]
  end

  def application do
    [
      applications: [
        :httpoison,
        :jsex
      ],
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

  defp description do
    """
    A simple Elixir HTTP client for Consul
    """
  end

  defp package do
    %{licenses: ["MIT"],
      links: %{"Github" => "https://github.com/undeadlabs/consul-ex"}}
  end
end
