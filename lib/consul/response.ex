#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Response do
  @type t :: HTTPoison.Response.t

  def consul_index(%{headers: %{"X-Consul-Index" => index}}), do: index
  def consul_index(_), do: nil
end
