defmodule JuserverWeb.UserResolver do
  use Ecto.Schema
  # import Ecto.Changeset

  alias Juserver.Accounts
  alias Juserver.Auth.Guardian

  def all_users(_root, _args, _info) do
    {:ok, Accounts.list_users()}
  end

  def signUp(args, _info) do
    Accounts.create_new_user(args)
  end

  def logIn(%{email: email, password: password}, _info) do
    IO.puts("En el resolver de login nuevo ")

    # IO.puts(email)
    # IO.puts(password)

    # {:ok, user} = Accounts.login_with_email_pass(email, password)
    # IO.inspect(user)

    # {:ok, jwt, _} = Guardian.encode_and_sign(user)
    # # IO.inspect(Guardian.encode_and_sign(user))

    # {:ok, _} = Accounts.store_token(user, jwt)

    # IO.inspect(jwt)
    # {:ok, %{token: jwt}}

    with {:ok, user} <- Accounts.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user),
         {:ok, _} <- Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt, user: user}}
    else
      _ ->
        {:error, "Not you."}
    end
  end

  def logout(_args, %{context: %{current_user: current_user, token: _token}}) do
    Accounts.revoke_token(current_user)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "Please, first Log In."}
  end

  def profile(_args, %{context: %{current_user: current_user, token: _token}}) do
    IO.puts("en el resolver del profile")
    {:ok, current_user}
    # case Accoutns.get_user_data(current_user) do
    #   nil -> {:error, "Not you."}
    #   user -> {:ok, user}
    # end
  end

  def profile(_args, _info) do
    {:error, "Please, first Log In."}
  end
end
