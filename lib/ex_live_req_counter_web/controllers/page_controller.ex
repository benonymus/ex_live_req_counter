defmodule ExLiveReqCounterWeb.PageController do
  use ExLiveReqCounterWeb, :controller

  alias ExLiveReqCounter.Cache

  def home(conn, _params) do
    key_count = Cache.count_all()
    render(conn, :home, key_count: key_count)
  end

  def new(conn, _params) do
    key = Nanoid.generate()
    Cache.put(key, 0)
    redirect(conn, to: ~p"/counts/#{key}")
  end
end
