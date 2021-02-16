defmodule Juserver.Groups.Affiliate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "affiliates" do
    # TO-DO change te type of the email to EmailEctoType
    field :email, :string
    field :name, :string

    many_to_many :groups, Juserver.Groups.Group,
      join_through: "groups_affiliates",
      on_replace: :delete,
      on_delete: :delete_all

    has_many :payments, Juserver.Groups.Payment

    timestamps()
  end

  @doc false
  def changeset(affiliate, attrs) do
    affiliate
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
