defmodule Juserver.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :day, :string
      add :hour, :float
      add :activity, :string

      timestamps()
    end

  end
end
