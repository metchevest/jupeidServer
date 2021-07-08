defmodule Juserver.Activities.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :activity, :string
    field :date, :string
    field :hour, :float
    field :name, :string

    many_to_many :students, Juserver.Groups.Student,
      join_through: "students_classes",
      on_replace: :delete,
      on_delete: :delete_all

    belongs_to :user, Juserver.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:date, :hour, :activity, :name])
    |> validate_required([:date, :hour, :activity])
  end
end
