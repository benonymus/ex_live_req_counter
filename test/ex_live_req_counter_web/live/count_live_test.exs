defmodule ExLiveReqCounterWeb.CountLiveTest do
  use ExLiveReqCounterWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Show" do
    test "displays count", %{conn: conn} do
      key = "test_key"
      ExLiveReqCounter.Cache.put(key, 0)
      {:ok, _show_live, html} = live(conn, ~p"/counts/#{key}")

      assert html =~ "Count for"
      assert html =~ key
    end
  end
end
