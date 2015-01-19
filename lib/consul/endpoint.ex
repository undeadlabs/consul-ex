#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Endpoint do
  @path_separator "/"

  @type response :: {:ok, Consul.Resposne.t} | {:error, Consul.Response.t}

  @spec build_url(binary | [binary], Keyword.t) :: binary
  def build_url(path, opts \\ [])
  def build_url(path, opts) when is_list(path) do
    List.flatten(path)
      |> Enum.join(@path_separator)
      |> build_url(opts)
  end
  def build_url(path, []), do: path
  def build_url(path, opts) when is_binary(path) do
    path <> "?" <> URI.encode_query(opts)
  end

  defmacro __using__(handler: handler) do
    quote do
      alias Consul.Request, as: Request
      import unquote(__MODULE__), only: [build_url: 1, build_url: 2]

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

      defp handle_response({:ok, response}), do: unquote(handler).handle(response)
      defp handle_response({:error, _} = error), do: error
    end
  end
end
