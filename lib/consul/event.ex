#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Event do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  defstruct id: nil,
    name: nil,
    payload: nil,
    node_filter: nil,
    service_filter: nil,
    tag_filter: nil,
    version: nil,
    l_time: nil

  @type t :: %{
    id: binary,
    name: binary,
    payload: binary | nil,
    service_filter: binary,
    tag_filter: binary,
    version: integer,
    l_time: integer,
  }

  @event "event"
  @fire  "fire"
  @list  "list"

  @spec fire(binary, binary, Keyword.t) :: Endpoint.response
  def fire(name, payload \\ "", opts \\ []) when is_binary(payload) do
    build_url([@event, @fire, name], opts)
      |> req_put(payload)
  end

  @doc """
  Build a list of `Consul.Event` from the given `Consul.Response`.
  """
  @spec from_response(Consul.Response.t) :: [t]
  def from_response(%{body: body}) when is_list(body) do
    Enum.map body, &build_event/1
  end

  @doc """
  Return the l_time of the most recent `Consul.Event` in the given list.
  """
  @spec last_time([t]) :: integer | nil
  def last_time([]), do: nil
  def last_time(events) do
    [%__MODULE__{l_time: time}|_] = sort(events)
    time
  end

  @spec list(Keyword.t) :: Endpoint.response
  def list(opts \\ []) do
    build_url([@event, @list], opts)
      |> req_get()
  end

  @doc """
  Sort a list of `Consul.Event` by their `l_time` field.
  """
  @spec sort([t]) :: [t]
  def sort(events) do
    Enum.sort events, &(&1.l_time > &2.l_time)
  end

  #
  # Private
  #

  defp build_event(%{"ID" => id, "Name" => name, "Payload" => nil, "NodeFilter" => node_filter,
    "ServiceFilter" => service_filter, "TagFilter" => tag_filter, "Version" => version, "LTime" => l_time}) do
    %Consul.Event{id: id, name: name, payload: nil, node_filter: node_filter, service_filter: service_filter,
      tag_filter: tag_filter, version: version, l_time: l_time}
  end
  defp build_event(%{"ID" => id, "Name" => name, "Payload" => payload, "NodeFilter" => node_filter,
    "ServiceFilter" => service_filter, "TagFilter" => tag_filter, "Version" => version, "LTime" => l_time}) do
    %Consul.Event{id: id, name: name, payload: :base64.decode(payload), node_filter: node_filter,
      service_filter: service_filter, tag_filter: tag_filter, version: version, l_time: l_time}
  end
end
