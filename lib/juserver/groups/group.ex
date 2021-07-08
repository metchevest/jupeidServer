defmodule Juserver.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :cost, :float
    field :name, :string

    many_to_many :students, Juserver.Groups.Student,
      join_through: "groups_students",
      on_replace: :delete,
      on_delete: :delete_all

    belongs_to :user, Juserver.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:cost, :name])
    |> validate_required([:cost, :name])
  end
end
