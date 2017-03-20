defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :consul,
      version: "1.0.3",
      elixir: "~> 1.0",
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
      {:httpoison, "~> 0.6"},
    ]
  end

  defp description do
    """
    An Elixir client for Consul's HTTP API
    """
  end

  defp package do
    %{licenses: ["MIT"],
      contributors: ["Jamie Winsor"],
      links: %{"Github" => "https://github.com/undeadlabs/consul-ex"}}
  end
end
