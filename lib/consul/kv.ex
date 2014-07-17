#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Consul.Kv do
  use Consul.Endpoint, handler: Consul.Handler.Kv

  def fetch(key) do
    req_get("kv/" <> key)
  end

  def fetch(index, key, opts \\ [wait: "10m"]) do
    req_get("kv/" <> key <> "?index=#{index}&wait=#{opts[:wait]}")
  end

  def fetch!(key) do
    case fetch(key) do
      {:ok, value} ->
        value
      {:error, response} ->
        raise(Consul.ResponseError, response)
    end
  end

  def fetch!(index, key, opts \\ [wait: "10m"]) do
    case fetch(index, key, opts) do
      {:ok, value} ->
        value
      {:error, response} ->
        raise(Consul.ResponseError, response)
    end
  end

  def keys(prefix) do
    req_get("kv/" <> prefix <> "?keys")
  end

  def keys!(prefix) do
    case keys(prefix) do
      {:ok, value} ->
        value
      {:error, response} ->
        raise(Consul.ResponseError, response)
    end
  end

  def put(key, value) do
    case req_put("kv/" <> key, value) do
      {:ok, %{body: body}} ->
        body
      error ->
        error
    end
  end

  def put!(key, value) do
    case put(key, value) do
      {:error, response} ->
        raise(Consul.ResponseError, response)
      result ->
        result
    end
  end
end
