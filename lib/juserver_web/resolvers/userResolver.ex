defmodule JuserverWeb.UserResolver do
  use Ecto.Schema
  # import Ecto.Changeset

  alias Juserver.Accounts

  def all_users(_root, _args, _info) do
    IO.puts("llegue al resolver")
    {:ok, Accounts.list_users()}
  end

  def signup(root, args, info) do
    IO.puts("Aca voy a imprimir")
    IO.inspect(root)
    IO.inspect(args)
    IO.inspect(info)
    {:ok, "dale"}
  end
end
