#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Agent.Service do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @agent      "agent"
  @deregister "deregister"
  @register   "register"
  @service    "service"

  @spec register(map, Keyword.t) :: Endpoint.response
  def register(%{"Name" => _} = body, opts \\ []) do
    build_url([@agent, @service, @register], opts)
      |> req_put(JSX.encode!(body))
  end

  @spec deregister(binary, Keyword.t) :: Endpoint.response
  def deregister(id, opts \\ []) do
    build_url([@agent, @service, @deregister, id], opts)
      |> req_delete()
  end
end
