defmodule ExLiveReqCounterWeb.CountJSON do
  def incr(%{count: count}) do
    %{data: %{count: count}}
  end
end
