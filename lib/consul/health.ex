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

  def state(id) do
    req_get("health/state/#{id}")
  end
end
