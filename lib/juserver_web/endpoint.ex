defmodule JuserverWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :juserver

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_juserver_key",
    signing_salt: "DpEVD4YO"
  ]

  socket "/socket", JuserverWeb.UserSocket,
    websocket: true,
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :juserver,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :juserver
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  # Check if I need the both of them
  # plug Absinthe.Plug,
  #   schema: JuserverWeb.Schema

  # plug CORSPlug

  # plug Corsica, origins: "*"

  plug Corsica,
    origins: [
      "http://localhost:3000"
    ],
    allow_headers: :all,
    allow_credentials: true,
    log: [rejected: :error, invalid: :warn, accepted: :debug]

  plug JuserverWeb.Context

  plug Absinthe.Plug.GraphiQL,
    schema: JuserverWeb.Schema,
    before_send: {JuserverWeb.Authentication.AbsintheCookieResponse, :absinthe_before_send}

  # plug Plug.MethodOverride
  # plug Plug.Head
  # plug Plug.Session, @session_options
  # plug JuserverWeb.Router
end
