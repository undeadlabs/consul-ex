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

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Consul.Worker, [arg1, arg2, arg3])
    ]

    opts = [strategy: :one_for_one, name: Consul.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

