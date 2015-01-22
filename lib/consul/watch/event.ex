#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Watch.Event do
  alias Consul.Watch
  alias Consul.Event

  use GenServer
  import Consul.Response, only: [consul_index: 1]

  @wait     "10m"
  @retry_ms 30 * 1000

  @spec start_link(binary, GenEvent.handler | {GenEvent.handler, list}) :: GenServer.on_start
  def start_link(name, handlers \\ []) do
    GenServer.start_link(__MODULE__, [name, handlers])
  end

  #
  # GenServer callbacks
  #

  def init([name, handlers]) do
    {:ok, em} = GenEvent.start_link(handlers)

    Enum.each handlers, fn
      {handler, args} ->
        :ok = GenEvent.add_handler(em, handler, args)
      handler ->
        :ok = GenEvent.add_handler(em, handler, [])
    end

    {:ok, %{name: name, em: em, index: nil, l_time: nil}, 0}
  end

  def handle_info(:timeout, %{name: name, index: index, em: em, l_time: l_time} = state) do
    case Event.list(wait: @wait, index: index) do
      {:ok, response} ->
        events     = Event.from_response(response) |> Enum.filter &(&1.name == name)
        new_l_time = Event.last_time(events)
        notify_events(events, em, index, l_time)
        {:noreply, %{state | index: consul_index(response), l_time: new_l_time}, 0}
      {:error, _response} ->
        {:noreply, state, @retry_ms}
    end
  end

  #
  # Private
  #

  defp notify_events(events, em, nil, _) do
    Watch.Handler.notify_events(em, events)
  end
  defp notify_events(events, em, _, last_time) do
    [latest|_] = Event.sort(events)
    if latest.l_time > last_time do
      Watch.Handler.notify_events(em, [latest])
    end
  end
end
