defmodule Juserver.Activities do
  @moduledoc """
  The Activities context.
  """

  import Ecto.Query, warn: false
  alias Juserver.Repo

  alias Juserver.Accounts.User
  alias Juserver.Activities.Class
  alias Juserver.Groups.Group

  def data() do
    Dataloader.Ecto.new(Juserver.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc """
  Returns the list of classes.

  ## Examples

      iex> list_classes()
      [%Class{}, ...]

  """
  def list_classes do
    Repo.all(Class)
  end

  @doc """
  Gets a single class.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class!(123)
      %Class{}

      iex> get_class!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class!(id), do: Repo.get!(Class, id)

  @doc """
  Creates a class.

  ## Examples

      iex> create_class(%{field: value})
      {:ok, %Class{}}

      iex> create_class(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class.

  ## Examples

      iex> update_class(class, %{field: new_value})
      {:ok, %Class{}}

      iex> update_class(class, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a class.

  ## Examples

      iex> delete_class(class)
      {:ok, %Class{}}

      iex> delete_class(class)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class changes.

  ## Examples

      iex> change_class(class)
      %Ecto.Changeset{data: %Class{}}

  """
  def change_class(%Class{} = class, attrs \\ %{}) do
    Class.changeset(class, attrs)
  end

  def get_user_class(user, class_id) do
    Repo.one(
      from c in Class,
        inner_join: g in assoc(c, :group),
        inner_join: u in assoc(g, :user),
        where: u.id == ^user.id and c.id == ^class_id
    )
  end

  def create_user_class(%{
        name: name,
        hour: hour,
        date: date,
        activity: activity,
        current_user: current_user
      }) do
    Repo.one(
      from u in User,
        where: u.id == ^current_user.id
    )
    |> Ecto.build_assoc(:classes, %{name: name, hour: hour, date: date, activity: activity})
    |> Repo.insert!()
  end

  def delete_user_class(%{current_user: _current_user, id: id}) do
    delete_class(Repo.get(Class, id))
  end

  def update_user_class(%{
        current_user: _current_user,
        id: id,
        name: name,
        hour: hour,
        date: date,
        activity: activity
      }) do
    IO.puts("estoy en el contexto")

    Repo.get(Class, id)
    |> update_class(%{name: name, hour: hour, date: date, activity: activity})
  end

  def list_user_classes(user) do
    Repo.all(
      from c in Class,
        inner_join: u in assoc(c, :user),
        where: u.id == ^user.id
    )
  end
end
