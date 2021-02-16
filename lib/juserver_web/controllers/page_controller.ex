defmodule JuserverWeb.PageController do
  use JuserverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
