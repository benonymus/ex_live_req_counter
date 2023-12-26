defmodule ExLiveReqCounterWeb.CountLive.Show do
  use ExLiveReqCounterWeb, :live_view

  alias ExLiveReqCounter.Cache

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       connected?: connected?(socket)
     )}
  end

  @impl true
  def handle_params(%{"key" => key}, _, socket) do
    if socket.assigns.connected?,
      do: Phoenix.PubSub.subscribe(ExLiveReqCounter.PubSub, key)

    {:noreply, assign(socket, page_title: "Count for #{key}", key: key, count: Cache.get(key))}
  end

  @impl true
  def handle_event("reset_count", _, %{assigns: %{key: key}} = socket) do
    Cache.put(key, 0)
    {:noreply, assign(socket, count: 0)}
  end

  @impl true
  def handle_info({:new_count, count}, socket) do
    {:noreply, assign(socket, count: count)}
  end

  def handle_info(_, socket), do: {:noreply, socket}
end
