defmodule JuserverWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query

  alias Juserver.Repo
  alias Juserver.Accounts.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    IO.puts("build context here must appeard the token**************")
    # IO.inspect(conn)
    IO.puts("*************")
    # IO.inspect(get_req_header(conn, "cookie"))

    # with ["authorization=" <> token] <- get_req_header(conn, "cookie") do
    #   IO.puts("inside the with1")
    #   IO.inspect(authorize(token))
    # end

    with ["authorization=" <> token] <- get_req_header(conn, "cookie"),
         {:ok, current_user} <- authorize(token) do
      IO.puts("inside the with2")
      IO.inspect(token)
      IO.inspect(current_user)
      IO.puts("*************")
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  def authorize(token) do
    IO.puts("in authorize")
    IO.inspect(token)

    # IO.inspect(User |> where(token: ^token |> Repo.one()))

    User
    |> where(token: ^token)
    |> Repo.one()
    |> case do
      nil ->
        {:error, "Invalid user"}

      user ->
        {:ok, user}
    end
  end
end
