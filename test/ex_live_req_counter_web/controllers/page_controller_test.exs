defmodule ExLiveReqCounterWeb.PageControllerTest do
  use ExLiveReqCounterWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Number of tracked counts"
  end

  test "GET /new", %{conn: conn} do
    conn = get(conn, ~p"/new")

    assert redirected_to(conn) =~ "/counts"
  end
end
