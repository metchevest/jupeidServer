defmodule Juserver.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :cost, :float
    field :name, :string

    many_to_many :affiliates, Juserver.Groups.Affiliate,
      join_through: "groups_affiliates",
      on_replace: :delete,
      on_delete: :delete_all

    has_many :classes, Juserver.Activities.Class
    belongs_to :user, Juserver.Accounts.User
    # ver si esta información no es redundante ? ?? si es redundante
    # la tendría que sacar?????
    has_many :payments, Juserver.Groups.Payment

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:cost])
    |> validate_required([:cost])
  end
end
