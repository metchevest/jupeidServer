defmodule Juserver.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :facebook_id, :string
      add :fantasy_name, :string
      add :month_income, :float
      add :email, :string
      add :password, :string
      add :token, :text
      add :tour, :boolean

      timestamps()
    end

  end
end
