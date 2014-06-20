defmodule Consul.Response do
  def consul_index(%{headers: %{"X-Consul-Index" => index}}), do: index
  def consul_index(_), do: nil
end
