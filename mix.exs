defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :consul,
      version: "0.2.0",
      elixir: "~> 1.0.0 or ~> 0.15.1",
      deps: deps,
      package: package,
      description: description
    ]
  end

  def application do
    [
      applications: [
        :httpoison,
        :exjsx
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
      {:exjsx, "~> 3.0"},
      {:httpoison, "~> 0.5.0"},
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
