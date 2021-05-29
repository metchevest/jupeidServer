defmodule JuserverWeb.Authentication.AbsintheCookieResponse do
  def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    if Map.has_key?(blueprint.execution.context, :access_token) do
      access_token = blueprint.execution.context.access_token

      Plug.Conn.put_resp_cookie(conn, "authorization", access_token || "",
        max_age: if(access_token, do: 25 * 365 * 25 * 60 * 60, else: -100_000),
        http_only: true,
        secure: true
        # same_site: "localhost:3000/",
        # domain: "localhost:4000"
      )
    else
      conn
    end
  end

  def absinthe_before_send(conn, _) do
    conn
  end
end
