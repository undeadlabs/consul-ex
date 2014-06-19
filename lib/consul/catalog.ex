defmodule Consul.Catalog do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def datacenters do
    req_get("catalog/datacenters")
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
    req_get("catalog/services/#{name}")
  end

  def service(index, name, opts \\ [wait: "10m"]) do
    req_get("catalog/services/#{name}?index=#{index}&wait=#{opts[:wait]}")
  end
end
