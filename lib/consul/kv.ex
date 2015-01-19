#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Kv do
  alias Consul.Response
  use Consul.Endpoint, handler: Consul.Handler.Kv

  @separator "/"

  @spec fetch(binary | [binary], Keyword.t) :: {:ok, Response.t} | {:error, Response.t}
  def fetch(key, opts \\ [])
  def fetch(path, opts) when is_list(path) do
    join_path(path) |> fetch(opts)
  end
  def fetch(key, opts) do
    req_get(join_path(["kv", key]) <> "?" <> URI.encode_query(opts))
  end

  @spec fetch!(binary | [binary], Keyword.t) :: Response.t | no_return
  def fetch!(key, opts \\ [])
  def fetch!(path, opts) when is_list(path) do
    join_path(path) |> fetch!(opts)
  end
  def fetch!(key, opts) do
    case fetch(key, opts) do
      {:ok, value} ->
        value
      {:error, response} ->
        raise(Consul.ResponseError, response)
    end
  end

  @spec keys(binary | [binary]) :: {:ok, Response.t} | {:error, Response.t}
  def keys(path) when is_list(path) do
    join_path(path) |> keys
  end
  def keys(prefix) do
    req_get(join_path(["kv", prefix]) <> "?keys")
  end

  @spec keys!(binary | [binary]) :: Response.t | no_return
  def keys!(path) when is_list(path) do
    join_path(path) |> keys!
  end
  def keys!(prefix) do
    case keys(prefix) do
      {:ok, value} ->
        value
      {:error, response} ->
        raise(Consul.ResponseError, response)
    end
  end

  @spec put(binary | [binary], term, Keyword.t) :: {:ok, Response.t} | {:error, Response.t}
  def put(key, value, opts \\ [])
  def put(path, value, opts) when is_list(path) do
    join_path(path) |> put(value, opts)
  end
  def put(key, value, opts) do
    case req_put(join_path(["kv", key]) <> "?" <> URI.encode_query(opts), value) do
      {:ok, %{body: body}} ->
        body
      error ->
        error
    end
  end

  @spec put!(binary | [binary], term, Keyword.t) :: Response.t | no_return
  def put!(key, value, opts \\ [])
  def put!(path, value, opts) when is_list(path) do
    join_path(path) |> put!(value, opts)
  end
  def put!(key, value, opts) do
    case put(key, value, opts) do
      {:error, response} ->
        raise(Consul.ResponseError, response)
      result ->
        result
    end
  end

  #
  # Private
  #

  defp join_path(path) when is_list(path) do
    Enum.join(path, @separator)
  end
end
