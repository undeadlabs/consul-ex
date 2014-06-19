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
