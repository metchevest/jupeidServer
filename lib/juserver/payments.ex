defmodule Juserver.Payments do
  @moduledoc """
  The Payments context.
  """

  import Ecto.Query, warn: false
  alias Juserver.Repo

  alias Juserver.Payments.Payment
  alias Juserver.Helpers

  def data() do
    Dataloader.Ecto.new(Juserver.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

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

  def add_payment_to_student(student, attrs) do
    IO.puts("estoy en add_payment_to_student")
    IO.inspect(student)
    {:ok, payment} = create_payment(attrs)
    new_payments = student.payments ++ [payment]

    IO.puts("new payments")
    IO.inspect(new_payments)

    student
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:payments, new_payments)
    |> Repo.update!()

    {:ok, Repo.preload(student, :payments)}
  end

  def create_user_payment(%{student_id: student_id, month: month, year: year}, user) do
    IO.puts("about to create the payment")
    IO.inspect(student_id)
    IO.inspect(month)
    IO.inspect(user)

    Helpers.get_user_student(student_id, user)
    |> add_payment_to_student(%{month: month, payment_date: NaiveDateTime.utc_now, year: year})
  end

  def get_payments(user) do
    # pay =
    Repo.all(
      from p in Payment,
        inner_join: s in assoc(p, :student),
        inner_join: u in assoc(s, :user),
        where: u.id == ^user.id
    )

    # p = Repo.all(Payment) |> Repo.preload(:student)

    # pay
  end

  def get_user_payments(user) do
    {:ok, get_payments(user)}
  end

  def set_next_payment(student) do
  end

  def next_payment_date(student) do
    # student
    # |> Repo.preload(:payments)
    # |>
  end

  def create_many_user_payments(%{students: student_list}, user) do
    Enum.map(student_list, fn %{id: id} ->
      Helpers.get_user_student(id, user)
      |> set_next_payment()
    end)
  end
end
