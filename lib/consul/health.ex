defmodule Consul.Health do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def checks(id) do
    req_get("health/checks/#{id}")
  end

  def node(id) do
    req_get("health/node/#{id}")
  end

  def service(id) do
    req_get("health/service/#{id}")
  end

  def service(index, id, opts \\ [wait: "10m"]) do
    req_get("health/service/#{id}?index=#{index}&wait=#{opts[:wait]}")
  end

  def state(id) do
    req_get("health/state/#{id}")
  end
end
