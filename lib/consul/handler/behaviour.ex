#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Handler.Behaviour do

  @callback handle(Consul.Response.t) :: Consule.Endpoint.response

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      @spec handle(Consul.Response.t) :: Consule.Endpoint.response
      def handle(%{status_code: 200} = response) do
        {:ok, response}
      end
      def handle(response) do
        {:error, response}
      end

      defoverridable [handle: 1]
    end
  end
end
