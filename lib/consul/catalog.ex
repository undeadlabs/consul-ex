#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Catalog do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @catalog     "catalog"
  @datacenters "datacenters"
  @deregister  "deregister"
  @nodes       "nodes"
  @node        "node"
  @services    "services"
  @service     "service"

  @spec datacenters(Keyword.t) :: Endpoint.response
  def datacenters(opts \\ []) do
    build_url([@catalog, @datacenters], opts)
      |> req_get()
  end

  @spec deregister(map, Keyword.t) :: Endpoint.response
  def deregister(%{"Datacenter" => _, "Node" => _} = body, opts \\ []) do
    build_url([@catalog, @deregister], opts)
      |> req_put(JSX.encode!(body))
  end

  @spec nodes(Keyword.t) :: Endpoint.response
  def nodes(opts \\ []) do
    build_url([@catalog, @nodes], opts)
      |> req_get()
  end

  @spec node(binary, Keyword.t) :: Endpoint.response
  def node(id, opts \\ []) do
    build_url([@catalog, @node, id], opts)
      |> req_get()
  end

  @spec services(Keyword.t) :: Endpoint.response
  def services(opts \\ []) do
    build_url([@catalog, @services], opts)
      |> req_get()
  end

  @spec service(binary, Keyword.t) :: Endpoint.response
  def service(name, opts \\ []) do
    build_url([@catalog, @service, name], opts)
      |> req_get()
  end
end
