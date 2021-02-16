defmodule Juserver.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :facebook_id, :string
    field :fantasy_name, :string
    field :month_income, :float
    field :name, :string

    has_many :groups, Juserver.Groups.Group
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :facebook_id, :fantasy_name, :month_income])
    |> validate_required([:name, :facebook_id, :fantasy_name])
  end
end
