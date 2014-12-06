#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Catalog do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def datacenters do
    req_get("catalog/datacenters")
  end

  def deregister(%{"Datacenter" => _, "Node" => _} = body) do
    req_put("catalog/deregister", JSX.encode!(body))
  end

  def nodes do
    req_get("catalog/nodes")
  end

  def node(id) do
    req_get("catalog/node/#{id}")
  end

  def services do
    req_get("catalog/services")
  end

  def service(name) do
    req_get("catalog/service/#{name}")
  end

  def service(index, name, opts \\ [wait: "10m"]) do
    req_get("catalog/service/#{name}?index=#{index}&wait=#{opts[:wait]}")
  end
end
