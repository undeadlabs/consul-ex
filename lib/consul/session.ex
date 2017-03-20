#
# The MIT License (MIT)
#
# Copyright (c) 2014-2015 Undead Labs, LLC
#

defmodule Consul.Session do
  alias Consul.Endpoint
  use Consul.Endpoint, handler: Consul.Handler.Base

  @session "session"
  @create  "create"
  @destroy "destroy"
  @info    "info"
  @list    "list"
  @node    "node"
  @renew   "renew"

  @spec create(map, Keyword.t) :: Endpoint.response
  def create(body, opts \\ []) do
    build_url([@session, @create], opts)
      |> req_put(JSX.encode!(body))
  end

  @spec create!(map, Keyword.t) :: binary | no_return
  def create!(body, opts \\ []) do
    case create(body, opts) do
      {:ok, %{body: body}} ->
        body["ID"]
      {:error, response} ->
        raise Consul.ResponseError, response
    end
  end

  @spec destroy(binary, Keyword.t) :: Endpoint.response
  def destroy(session_id, opts \\ []) do
    build_url([@session, @destroy, session_id], opts)
      |> req_put("")
  end

  @spec info(binary, Keyword.t) :: Endpoint.response
  def info(session_id, opts \\ []) do
    build_url([@session, @info, session_id], opts)
      |> req_get()
  end

  @spec node(binary, Keyword.t) :: Endpoint.response
  def node(node_id, opts \\ []) do
    build_url([@session, @node, node_id], opts)
      |> req_get()
  end

  @spec list(Keyword.t) :: Endpoint.response
  def list(opts \\ []) do
    build_url([@session, @list], opts)
      |> req_get()
  end

  @spec renew(binary, Keyword.t) :: Endpoint.response
  def renew(session_id, opts \\ []) do
    build_url([@session, @renew, session_id], opts)
      |> req_put("")
  end
end
