defmodule ExLiveReqCounterWeb.CountControllerTest do
  use ExLiveReqCounterWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "incr" do
    test "key value increases", %{conn: conn} do
      key = "test_key"
      ExLiveReqCounter.Cache.put(key, 0)
      conn = get(conn, ~p"/api/counts/#{key}")
      assert json_response(conn, 200)["data"] == %{"count" => 1}
    end
  end
end
