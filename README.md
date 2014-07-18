# Consul

A simple Elixir HTTP client for Consul

## Requirements

* Elixir 0.14.0 or newer

## Installation

Add Consul as a dependency in your `mix.exs` file

```elixir
def application do
  [applications: [:consul]]
end

defp deps do
  [
    {:consul, "~> 0.1.0"},
    {:hackney, github: "benoitc/hackney"},
  ]
end
```

Then run `mix deps.get` in your shell to fetch the dependencies.

> NOTE: Hackney is currently not hosted on [Hex](https://hex.pm) so it must be added explicitly as a github dependency

## Authors

Jamie Winsor (<jamie@undeadlabs.com>)
