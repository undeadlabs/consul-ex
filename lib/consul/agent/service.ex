defmodule Consul.Agent.Service do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def register(%{"Name" => _} = body) do
    req_put("agent/service/register", JSEX.encode!(body))
  end

  def deregister(id) do
    req_delete("agent/service/deregister/#{id}")
  end
end
