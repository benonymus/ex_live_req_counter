defmodule ExLiveReqCounterWeb.CountController do
  use ExLiveReqCounterWeb, :controller

  alias ExLiveReqCounter.Cache

  def incr(conn, %{"key" => key}) do
    count = Cache.incr(key)

    Phoenix.PubSub.broadcast(ExLiveReqCounter.PubSub, key, {:new_count, count})

    render(conn, :incr, count: count)
  end
end
