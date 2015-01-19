#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Handler.Kv do
  use Consul.Handler.Behaviour

  def handle(%{status_code: 200, body: body} = response) do
    {:ok, %{response | body: decode_body(body)}}
  end
  def handle(response), do: super(response)

  #
  # Private API
  #

  defp decode_body(items) when is_list(items) do
    Enum.map(items, &decode_body/1)
  end
  defp decode_body(%{"Value" => value} = item) when is_binary(value) do
    %{item | "Value" => :base64.decode(value)}
  end
  defp decode_body(item), do: item
end
