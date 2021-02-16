defmodule Juserver.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :month, :integer
      add :amount, :float

      timestamps()
    end

  end
end
