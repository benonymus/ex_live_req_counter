defmodule ExLiveReqCounterWeb.CountJSON do
  def incr(%{count: count}) do
    %{count: count}
  end
end
