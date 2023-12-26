defmodule ExLiveReqCounterWeb.Router do
  use ExLiveReqCounterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ExLiveReqCounterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExLiveReqCounterWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/new", PageController, :new

    pipe_through :key_check
    live "/counts/:key", CountLive.Show, :show
  end

  scope "/api", ExLiveReqCounterWeb do
    pipe_through :api

    scope "/counts" do
      pipe_through :key_check
      get "/:key", CountController, :incr
    end
  end

  # meh key validation
  defp key_check(conn, _opts) do
    with %{"key" => key} <- conn.params,
         false <- key |> ExLiveReqCounter.Cache.get() |> is_nil do
      conn
    else
      %{} ->
        conn

      true ->
        conn
        |> fetch_session()
        |> fetch_flash()
        |> put_flash(:error, "Key does not exist!")
        |> redirect(to: "/")
        |> halt()
    end
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:ex_live_req_counter, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExLiveReqCounterWeb.Telemetry
    end
  end
end
