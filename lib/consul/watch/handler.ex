#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Watch.Handler do
  use Behaviour

  @type on_return :: {:ok, term} | :remove_handler

  @doc """
  Handle notifications of Consul Events. When the handler is initially added all prior events
  will be notified to the handler, subsequent notifications will occur only upon change.

  See: http://www.consul.io/docs/agent/http.html#event
  """
  defcallback handle_consul_events(events :: [Consul.Event.t], list) :: on_return

  defmacro __using__(_) do
    quote do
      @behaviour Consul.Watch.Handler
      use GenEvent

      @doc false
      def handle_event({:consul_events, events}, state) do
        handle_consul_events(events, state)
      end

      @doc false
      def handle_consul_events(_events, state) do
        {:ok, state}
      end

      defoverridable [handle_consul_events: 2]
    end
  end

  #
  # Public API
  #

  @doc """
  Notifies handlers attached a Watch's event manager of Consul Events.
  """
  @spec notify_events(GenEvent.manager, [Consul.Event.t]) :: :ok
  def notify_events(_, []), do: :ok
  def notify_events(manager, events) when is_pid(manager) and is_list(events) do
    GenEvent.ack_notify(manager, {:consul_events, events})
  end
end
