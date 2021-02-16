defmodule Juserver.Activities.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :activity, :string
    field :day, :string
    field :hour, :float

    belongs_to :group, Juserver.Groups.Group

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:day, :hour, :activity])
    |> validate_required([:day, :hour, :activity])
  end
end
