defmodule Juserver.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Argon2

  import Ecto.Query, warn: false
  alias Juserver.Repo

  alias Juserver.Accounts.User
  alias Juserver.Groups

  def data() do
    Dataloader.Ecto.new(Juserver.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.name == ^username

    verify_user(query, plain_text_password)
  end

  def login_with_email_pass(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    verify_user(query, plain_text_password)
  end

  def verify_user(query, plain_text_password) do
    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def store_token(%User{} = user, token) do
    update_user(user, %{token: token})
  end

  def revoke_token(%User{} = user) do
    user
    |> User.store_token_changeset(%{token: nil})
    |> Repo.update()
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload([:groups])
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def add_group_to_user(group, user) do
    user = Repo.preload(user, :groups)

    group
    |> Repo.preload(:user)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.update!()
  end

  def new_group_to_user(user, params) do
    params
    |> Groups.create_group()
    |> elem(1)
    |> add_group_to_user(user)
  end

  def create_new_user(%{email: email, password: password}) do
    case check_new_email(email) do
      true -> {:error, "E-mail already in use"}
      false -> send_unique_mail_user(create_user(%{email: email, password: password}))
    end
  end

  def send_unique_mail_user({:ok, user}) do
    {:ok, user}
  end

  def send_unique_mail_user({:error, _msg}) do
    {:error, "Not now."}
  end

  def check_new_email(email) do
    case Repo.all(from u in User, where: u.email == ^email) do
      [] -> false
      _list -> true
    end
  end
end
