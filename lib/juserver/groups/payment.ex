defmodule Juserver.Groups.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :float
    # This is a bug, must change, which month ?
    field :month, :integer

    belongs_to :group, Juserver.Groups.Group
    belongs_to :affiliate, Juserver.Groups.Affiliate

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:month, :amount])
    |> validate_required([:month, :amount])
  end
end
