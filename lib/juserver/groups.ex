defmodule Juserver.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Juserver.Repo

  alias Juserver.Groups.{Group, Affiliate, Payment}
  alias Juserver.Activities
  alias Juserver.Accounts.User

  def data() do
    Dataloader.Ecto.new(Juserver.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  alias Juserver.Groups.Payment

  @doc """
  Returns the list of payments.

  ## Examples

      iex> list_payments()
      [%Payment{}, ...]

  """
  def list_payments do
    Repo.all(Payment)
  end

  @doc """
  Gets a single payment.

  Raises `Ecto.NoResultsError` if the Payment does not exist.

  ## Examples

      iex> get_payment!(123)
      %Payment{}

      iex> get_payment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payment!(id), do: Repo.get!(Payment, id)

  @doc """
  Creates a payment.

  ## Examples

      iex> create_payment(%{field: value})
      {:ok, %Payment{}}

      iex> create_payment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment(attrs \\ %{}) do
    %Payment{}
    |> Payment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payment.

  ## Examples

      iex> update_payment(payment, %{field: new_value})
      {:ok, %Payment{}}

      iex> update_payment(payment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment(%Payment{} = payment, attrs) do
    payment
    |> Payment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payment.

  ## Examples

      iex> delete_payment(payment)
      {:ok, %Payment{}}

      iex> delete_payment(payment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment(%Payment{} = payment) do
    Repo.delete(payment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment changes.

  ## Examples

      iex> change_payment(payment)
      %Ecto.Changeset{data: %Payment{}}

  """
  def change_payment(%Payment{} = payment, attrs \\ %{}) do
    Payment.changeset(payment, attrs)
  end

  alias Juserver.Groups.Affiliate

  @doc """
  Returns the list of affiliates.

  ## Examples

      iex> list_affiliates()
      [%Affiliate{}, ...]

  """
  def list_affiliates do
    Repo.all(Affiliate)
  end

  @doc """
  Gets a single affiliate.

  Raises `Ecto.NoResultsError` if the Affiliate does not exist.

  ## Examples

      iex> get_affiliate!(123)
      %Affiliate{}

      iex> get_affiliate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_affiliate!(id), do: Repo.get!(Affiliate, id)

  @doc """
  Creates a affiliate.

  ## Examples

      iex> create_affiliate(%{field: value})
      {:ok, %Affiliate{}}

      iex> create_affiliate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_affiliate(attrs \\ %{}) do
    %Affiliate{}
    |> Affiliate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a affiliate.

  ## Examples

      iex> update_affiliate(affiliate, %{field: new_value})
      {:ok, %Affiliate{}}

      iex> update_affiliate(affiliate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_affiliate(%Affiliate{} = affiliate, attrs) do
    affiliate
    |> Affiliate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a affiliate.

  ## Examples

      iex> delete_affiliate(affiliate)
      {:ok, %Affiliate{}}

      iex> delete_affiliate(affiliate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_affiliate(%Affiliate{} = affiliate) do
    Repo.delete(affiliate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking affiliate changes.

  ## Examples

      iex> change_affiliate(affiliate)
      %Ecto.Changeset{data: %Affiliate{}}

  """
  def change_affiliate(%Affiliate{} = affiliate, attrs \\ %{}) do
    Affiliate.changeset(affiliate, attrs)
  end

  def add_class_to_group(class, group) do
    group = Repo.preload(group, :classes)

    class
    |> Repo.preload(:group)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.update!()
  end

  def add_new_class_to_group(group, params) do
    params
    |> Activities.create_class()
    |> elem(1)
    |> add_class_to_group(group)
  end

  def add_affiliate(group, affiliate) do
    (group.affiliates ++ [affiliate]) |> Enum.map(&Ecto.Changeset.change/1)
  end

  def add_affiliate_to_group(affiliate, group) do
    group
    |> Repo.preload(:affiliates)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:affiliates, add_affiliate(group, affiliate))
    |> Repo.update!()
  end

  def add_new_affiliate_to_group(group, params) do
    params
    |> create_affiliate()
    |> elem(1)
    |> add_affiliate_to_group(group)
  end

  def add_payment_to_affiliate(payment, affiliate, group) do
    payment
    |> Repo.preload([:group, :affiliate])
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Ecto.Changeset.put_assoc(:affiliate, affiliate)
    |> Repo.update!()
  end

  def add_new_payment_to_affiliate(affiliate, group, params) do
    params
    |> create_payment()
    |> elem(1)
    |> add_payment_to_affiliate(affiliate, group)
  end

  def list_user_groups(%{id: id}) do
    Repo.all(from g in Group, inner_join: u in assoc(g, :user), where: u.id == ^id)
  end

  def create_user_group(%{name: name, cost: cost, user: user}) do
    Repo.one(from u in User, where: u.id == ^user.id)
    |> Ecto.build_assoc(:groups, %{cost: cost, name: name})
    |> Repo.insert!()
  end

  def get_group_classes(user_id, id) do
    Repo.all(
      from g in Group, inner_join: u in assoc(g, :user), where: g.id == ^id and u.id == ^user_id
    )
  end

  def list_user_affiliates(user) do
    Repo.all(
      from a in Affiliate,
        inner_join: u in assoc(a, :user),
        where: u.id == ^user.id
    )
  end

  def get_affilite_user(%{user_id: user_id, id: id}) do
    Repo.one(
      from a in Affiliate,
        inner_join: g in assoc(a, :groups),
        inner_join: u in assoc(g, :user),
        where: u.id == ^user_id and a.id == ^id
    )
  end

  # This is and old version of the function, now I'm creating the affiliate without the group
  # def create_user_affiliate(%{email: email, user_id: user_id, name: name, group_id: group_id}) do
  #   # TO-DO I'm not proud of this function. Improve.
  #   group =
  #     Repo.one(
  #       from g in Group,
  #         inner_join: u in assoc(g, :user),
  #         where: u.id == ^user_id and g.id == ^group_id
  #     )
  #     |> Repo.preload(:affiliates)

  #   affiliate = %Affiliate{email: email, name: name} |> Repo.insert!()

  #   add_affiliate_to_group(affiliate, group)

  #   affiliate
  # end

  def create_user_affiliate(%{name: name, email: email, user: user}) do
    Repo.one(from u in User, where: u.id == ^user.id)
    |> Ecto.build_assoc(:affiliates, %{name: name, email: email})
    |> Repo.insert!()
  end

  def get_affiliate_payments(%{id: id}) do
    Repo.all(from p in Payment, inner_join: a in assoc(p, :affiliate), where: a.id == ^id)
  end

  def create_user_payment(args) do
    IO.puts("Llegue al contexto")
    IO.inspect(args)
  end

  def get_group_affiliates(args) do
    IO.puts("llegue al context")
    IO.inspect(args)
  end

  def get_affiliate_groups(args) do
    IO.puts("llegue al context")
    IO.inspect(args)
  end

  def delete_user_group(%{id: id}) do
    IO.puts(id)

    Group
    |> Repo.get(id)
    |> Repo.delete()
  end

  def edit_user_group(%{id: id, cost: cost, name: name, user: user}) do
    IO.puts("Estoy en el contexto con los datos")
    IO.inspect(name)
    IO.inspect(cost)

    Repo.one(
      from g in Group,
        inner_join: u in assoc(g, :user),
        where: g.id == ^id and u.id == ^user.id
    )
    |> update_group(%{cost: cost, name: name})
  end

  def delete_user_affiliate(id, user) do
    Repo.one(
      from a in Affiliate,
        inner_join: u in assoc(a, :user),
        where: a.id == ^id and u.id == ^user.id
    )
    |> Repo.delete!()
  end

  def edit_user_affiliate(%{id: id, name: name, email: email, user: user}) do
    IO.puts("estyo en el contexto")

    Repo.one(
      from a in Affiliate,
        inner_join: u in assoc(a, :user),
        where: a.id == ^id and u.id == ^user.id
    )
    |> update_affiliate(%{name: name, email: email})
  end
end
