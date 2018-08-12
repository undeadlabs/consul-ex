defmodule Consul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :consul,
      version: "1.1.0",
      elixir: "~> 1.6",
      deps: deps(),
      package: package(),
      description: description()
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
      {:exjsx, "~> 4.0.0"},
      {:httpoison, "~> 1.2.0"},
      {:ex_doc, "~> 0.19.1", only: :dev}
    ]
  end

  defp description do
    """
    An Elixir client for Consul's HTTP API
    """
  end

  defp package do
    %{licenses: ["MIT"],
      maintainers: ["Jamie Winsor"],
      links: %{"Github" => "https://github.com/undeadlabs/consul-ex"}}
  end
end
