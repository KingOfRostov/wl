defmodule WlWeb.Router do
  use WlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug :accepts, ["json"]
  end

  pipeline :user_auth do
    plug Wl.Accounts.Services.UserAuthPlug
  end

  scope "/", WlWeb do
    pipe_through :api

    get "/", PageController, :index
    resources "/session", Accounts.SessionController, only: [:create, :new]
    delete "/session", Accounts.SessionController, :delete, singleton: true
    post "/session/check", Accounts.SessionController, :check, singleton: true
    resources "/users", Accounts.UserController, only: [:new, :create]

    pipe_through [:user_auth]

    resources "/users", Accounts.UserController, except: [:delete, :new, :create]
    post "/users/:id/follow", Accounts.UserController, :follow
    post "/users/:id/unfollow", Accounts.UserController, :unfollow
    resources "/wishes", Properties.WishController, except: [:delete]
    post "/wishes/:id/archive", Properties.WishController, :archive
  end

  # Other scopes may use custom stacks.
  # scope "/api", WlWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: WlWeb.Telemetry
    end
  end
end
