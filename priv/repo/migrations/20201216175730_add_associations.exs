defmodule Juserver.Repo.Migrations.AddAssociations do
  use Ecto.Migration

  def change do

    create table(:groups_affiliates) do
      add :group_id, references(:groups)
      add :affiliate_id, references(:affiliates)
    end

    create unique_index(:groups_affiliates, [:group_id, :affiliate_id])

    alter table(:groups) do
      add :user_id, references(:users)
    end

    alter table(:affiliates) do
      add :user_id, references(:users)
    end

    alter table(:classes) do
      add :group_id, references(:groups)
      add :user_id, references(:users)
    end

    alter table(:payments) do
      add :group_id, references(:groups)
      add :affiliate_id, references(:affiliates)
    end


  end
end
