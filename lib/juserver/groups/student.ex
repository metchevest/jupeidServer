defmodule Juserver.Groups.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    # TO-DO change te type of the email to EmailEctoType
    field :email, :string
    field :name, :string

    many_to_many :groups, Juserver.Groups.Group,
      join_through: "groups_students",
      on_replace: :delete,
      on_delete: :delete_all

    many_to_many :classes, Juserver.Activities.Class,
      join_through: "students_classes",
      on_replace: :delete,
      on_delete: :delete_all

    has_many :payments, Juserver.Payments.Payment

    belongs_to :user, Juserver.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
