defmodule Juserver.Repo.Migrations.CreateAffiliates do
  use Ecto.Migration

  def change do
    create table(:affiliates) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
