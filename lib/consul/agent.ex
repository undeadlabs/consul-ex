#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Agent do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @agent       "agent"
  @checks      "checks"
  @force_leave "force-leave"
  @join        "join"
  @members     "members"
  @self        "self"
  @services    "services"

  @spec checks(Keyword.t) :: Endpoint.response
  def checks(opts \\ []) do
    build_url([@agent, @checks], opts)
      |> req_get()
  end

  @spec join(binary, Keyword.t) :: Endpoint.response
  def join(address, opts \\ []) do
    build_url([@agent, @join, address], opts)
      |> req_get()
  end

  @spec force_leave(binary, Keyword.t) :: Endpoint.response
  def force_leave(node, opts \\ []) do
    build_url([@agent, @force_leave, node], opts)
      |> req_get()
  end

  @spec members(Keyword.t) :: Endpoint.response
  def members(opts \\ []) do
    build_url([@agent, @members], opts)
      |> req_get()
  end

  @spec self(Keyword.t) :: Endpoint.response
  def self(opts \\ []) do
    build_url([@agent, @self], opts)
      |> req_get()
  end

  @spec services(Keyword.t) :: Endpoint.response
  def services(opts \\ []) do
    build_url([@agent, @services], opts)
      |> req_get()
  end
end
