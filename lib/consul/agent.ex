defmodule Consul.Agent do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def checks do
    req_get("agent/checks")
  end

  def members do
    req_get("agent/members")
  end

  def self do
    req_get("agent/self")
  end

  def services do
    req_get("agent/services")
  end
end
