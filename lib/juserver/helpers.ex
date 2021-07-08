defmodule Juserver.Helpers do
  import Ecto.Query, warn: false

  alias Juserver.Repo

  alias Juserver.Groups.Student

  def get_user_student(student_id, user) do
    get_student(student_id, user.id)
    |> Repo.preload([:classes, :groups, :payments])
  end

  def get_student(student_id, user_id) do
    Repo.one(
      from a in Student,
        inner_join: u in assoc(a, :user),
        where: a.id == ^student_id and u.id == ^user_id
    )
  end
end
