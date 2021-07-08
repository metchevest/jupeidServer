defmodule Juserver.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :float
    field :month, :integer
    field :year, :integer
    field :payment_date, :date

    belongs_to :student, Juserver.Groups.Student

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:month, :year, :payment_date])
    |> validate_required([:month, :year, :payment_date])
  end
end
