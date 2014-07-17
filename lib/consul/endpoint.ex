#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Endpoint do
  defmacro __using__(handler: handler) do
    quote do
      alias Consul.Request, as: Request

      defp req_get(url, headers \\ [], options \\ []) do
        Request.get(url, headers, options) |> handle_response
      end

      defp req_put(url, body, headers \\ [], options \\ []) do
        Request.put(url, body, headers, options) |> handle_response
      end

      defp req_head(url, headers \\ [], options \\ []) do
        Request.head(url, headers, options) |> handle_response
      end

      defp req_post(url, body, headers \\ [], options \\ []) do
        Request.post(url, body, headers, options) |> handle_response
      end

      defp req_patch(url, body, headers \\ [], options \\ []) do
        Request.patch(url, body, headers, options) |> handle_response
      end

      defp req_delete(url, headers \\ [], options \\ []) do
        Request.delete(url, headers, options) |> handle_response
      end

      defp req_options(url, headers \\ [], options \\ []) do
        Request.options(url, headers, options) |> handle_response
      end

      defp handle_response(response), do: unquote(handler).handle(response)
    end
  end
end
