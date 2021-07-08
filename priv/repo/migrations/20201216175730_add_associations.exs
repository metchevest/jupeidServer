defmodule Juserver.Repo.Migrations.AddAssociations do
  use Ecto.Migration

  def change do

    create table(:students_classes) do
      add :student_id, references(:students)
      add :class_id, references(:classes)
    end

    create unique_index(:students_classes, [:class_id, :student_id])

    create table(:groups_students) do
      add :student_id, references(:students)
      add :group_id, references(:groups)
    end

    create unique_index(:groups_students, [:group_id, :student_id])

    alter table(:groups) do
      add :user_id, references(:users)
    end

    alter table(:students) do
      add :user_id, references(:users)
    end

    alter table(:classes) do
      add :group_id, references(:groups)
      add :user_id, references(:users)
    end

    alter table(:payments) do
      add :student_id, references(:students)
    end


  end
end
