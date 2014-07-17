#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Request do
  use HTTPoison.Base

  def process_url(url) do
    "http://#{host}:#{port}/v1/" <> url
  end

  def process_response_body(body) do
    case JSEX.decode(body) do
      {:ok, decoded} ->
        decoded
      _ ->
        body
    end
  end

  @doc false
  def request(method, url, body \\ "", headers \\ [], options \\ []) do
    try do
      super(method, url, body, headers, options)
    rescue
      error in [HTTPoison.HTTPError] ->
        error.message
    end
  end

  #
  # Private API
  #

  defp host do
    Application.get_env(:consul, :host, "localhost")
  end

  defp port do
    Application.get_env(:consul, :port, 8500)
  end
end
