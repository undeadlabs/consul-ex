defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :consul,
      version: "0.1.0",
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
      {:httpoison, "~> 0.3.0"},
      {:hackney, github: "benoitc/hackney"},
    ]
  end

  defp description do
    """
    A simple Elixir HTTP client for Consul
    """
  end

  defp package do
    %{licenses: ["MIT"],
      contributors: ["Jamie Winsor"],
      links: %{"Github" => "https://github.com/undeadlabs/consul-ex"}}
  end
end
