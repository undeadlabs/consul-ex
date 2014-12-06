#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Agent.Service do
  use Consul.Endpoint, handler: Consul.Handler.Base

  def register(%{"Name" => _} = body) do
    req_put("agent/service/register", JSX.encode!(body))
  end

  def deregister(id) do
    req_delete("agent/service/deregister/#{id}")
  end
end
