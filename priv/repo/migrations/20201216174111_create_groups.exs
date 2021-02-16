defmodule Juserver.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :cost, :float
      add :name, :string

      timestamps()
    end

  end
end
