#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Event do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @event "event"
  @fire  "fire"
  @list  "list"

  @spec list(Keyword.t) :: Endpoint.response
  def list(opts \\ []) do
    build_url([@event, @list], opts)
      |> req_get()
  end

  @spec fire(binary, binary, Keyword.t) :: Endpoint.response
  def fire(name, payload \\ "", opts \\ []) when is_binary(payload) do
    build_url([@event, @fire, name], opts)
      |> req_put(payload)
  end
end
