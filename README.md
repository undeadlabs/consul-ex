# Consul

[![Build Status](https://travis-ci.org/undeadlabs/consul-ex.png?branch=master)](https://travis-ci.org/undeadlabs/consul-ex)

An Elixir client for Consul's HTTP API

## Requirements

* Elixir 1.0.0 or newer

## Installation

Add Consul as a dependency in your `mix.exs` file

```elixir
def application do
  [applications: [:consul]]
end

defp deps do
  [
    {:consul, "~> 1.0.0"}
  ]
end
```

Then run `mix deps.get` in your shell to fetch the dependencies.

## Docs

Run `mix docs` and open `doc/index.html` to view the documentation.

## Authors

Jamie Winsor (<jamie@undeadlabs.com>)
