#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Request do
  use HTTPoison.Base

  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> ->
        url
      <<"https://"::utf8, _::binary>> ->
        url
      _ ->
        Path.join("http://#{host}:#{port}/v1", url)
    end
  end

  def process_response_body(body) do
    case JSEX.decode(body) do
      {:ok, decoded} ->
        decoded
      _ ->
        body
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
