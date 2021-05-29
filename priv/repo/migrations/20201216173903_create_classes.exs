defmodule Juserver.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :date, :string
      add :hour, :float
      add :activity, :string
      add :name, :string

      timestamps()
    end

  end
end
