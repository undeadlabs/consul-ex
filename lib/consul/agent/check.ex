defmodule Consul.Agent.Check do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def register(body) do
    req_put("agent/check/register", JSEX.encode!(body))
  end

  def deregister(id) do
    req_delete("agent/check/deregister/#{id}")
  end

  def pass(id) do
    req_get("agent/check/pass/#{id}")
  end

  def warn(id) do
    req_get("agent/check/warn/#{id}")
  end

  def fail(id) do
    req_get("agent/check/fail/#{id}")
  end
end
