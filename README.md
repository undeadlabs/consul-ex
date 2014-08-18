# Consul

[![Build Status](https://travis-ci.org/undeadlabs/consul-ex.png?branch=master)](https://travis-ci.org/undeadlabs/consul-ex)

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
    {:consul, "~> 0.1.0"}
  ]
end
```

Then run `mix deps.get` in your shell to fetch the dependencies.

## Authors

Jamie Winsor (<jamie@undeadlabs.com>)
