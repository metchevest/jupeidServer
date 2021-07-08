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
    with {:ok, user} <- Accounts.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user),
         {:ok, _} <- Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt, user: user}}
    else
      _ ->
        {:error, "Not you."}
    end
  end

  def logout(_args, %{context: %{current_user: current_user}}) do
    Accounts.revoke_token(current_user)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "Please, first Log In."}
  end

  def profile(_args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def profile(_args, _info) do
    {:error, "Please, first Log In."}
  end

  def set_user_tour(%{tour: tour}, %{context: %{current_user: current_user}}) do
    {:ok, Accounts.set_turn(tour, current_user)}
  end

  def set_user_tour(_args, _info) do
    {:error, "Please, first Log In."}
  end
end
