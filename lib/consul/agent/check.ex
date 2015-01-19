#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Agent.Check do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @agent      "agent"
  @check      "check"
  @deregister "deregister"
  @fail       "fail"
  @pass       "pass"
  @register   "register"
  @warn       "warn"

  @spec register(map, Keyword.t) :: Endpoint.response
  def register(body, opts \\ []) do
    build_url([@agent, @check, @register], opts)
      |> req_put(JSX.encode!(body))
  end

  @spec deregister(binary, Keyword.t) :: Endpoint.response
  def deregister(id, opts \\ []) do
    build_url([@agent, @check, @deregister, id], opts)
      |> req_delete()
  end

  @spec pass(binary, Keyword.t) :: Endpoint.response
  def pass(id, opts \\ []) do
    build_url([@agent, @check, @pass, id], opts)
      |> req_get()
  end

  @spec warn(binary, Keyword.t) :: Endpoint.response
  def warn(id, opts \\ []) do
    build_url([@agent, @check, @warn, id], opts)
      |> req_get()
  end

  @spec fail(binary, Keyword.t) :: Endpoint.response
  def fail(id, opts \\ []) do
    build_url([@agent, @check, @fail, id], opts)
      |> req_get()
  end
end
