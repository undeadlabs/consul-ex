#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul do
  defmodule ResponseError do
    defexception response: nil

    def exception(value) do
      %__MODULE__{response: value}
    end

    def message(%{response: response}) do
      "Got non-200 OK status code: #{response.status_code}"
    end
  end

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    opts = [strategy: :one_for_one, name: Consul.Supervisor]
    Supervisor.start_link([], opts)
  end
end

