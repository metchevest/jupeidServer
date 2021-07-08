defmodule Juserver.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Juserver.Repo

  alias Juserver.Helpers
  alias Juserver.Groups.{Group, Student}
  alias Juserver.Activities.{Class}
  alias Juserver.Accounts.User

  def data() do
    Dataloader.Ecto.new(Juserver.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end

  def list_user_groups(%{id: id}) do
    Repo.all(from g in Group, inner_join: u in assoc(g, :user), where: u.id == ^id)
  end

  def create_user_group(%{name: name, cost: cost, user: user}) do
    user
    |> Repo.preload(:groups)
    |> Ecto.build_assoc(:groups, %{cost: cost, name: name})
    |> Repo.insert!()
  end

  def get_group_classes(user_id, id) do
    Repo.all(
      from g in Group, inner_join: u in assoc(g, :user), where: g.id == ^id and u.id == ^user_id
    )
  end

  def list_user_students(user) do
    IO.puts("list_user_students")
    IO.inspect(user)

    Repo.all(
      from a in Student,
        inner_join: u in assoc(a, :user),
        where: u.id == ^user.id
    )
  end

  def get_affilite_user(%{user_id: user_id, id: id}) do
    Repo.one(
      from a in Student,
        inner_join: g in assoc(a, :groups),
        inner_join: u in assoc(g, :user),
        where: u.id == ^user_id and a.id == ^id
    )
  end

  def create_user_student(%{name: name, email: email, user: user}) do
    user
    |> Repo.preload(:students)
    |> Ecto.build_assoc(:students, %{name: name, email: email})
    |> Repo.insert!()
  end

  def get_student_payments(%{id: id}) do
    Repo.all(from p in Payment, inner_join: a in assoc(p, :student), where: a.id == ^id)
  end

  def create_user_payment(args) do
    IO.puts("Llegue al contexto")
    IO.inspect(args)
  end

  def get_group_students(args) do
    IO.puts("llegue al context")
    IO.inspect(args)
  end

  def get_student_groups(args) do
    IO.puts("llegue al context")
    IO.inspect(args)
  end

  def delete_user_group(%{id: id}) do
    Group
    |> Repo.get(id)
    |> Repo.delete()
  end

  def edit_user_group(%{id: id, cost: cost, name: name, user: user}) do
    Repo.one(
      from g in Group,
        inner_join: u in assoc(g, :user),
        where: g.id == ^id and u.id == ^user.id
    )
    |> update_group(%{cost: cost, name: name})
  end

  def delete_user_student(id, user) do
    Repo.one(
      from a in Student,
        inner_join: u in assoc(a, :user),
        where: a.id == ^id and u.id == ^user.id
    )
    |> Repo.delete!()
  end

  def edit_user_student(%{id: id, name: name, email: email, user: user}) do
    Repo.one(
      from a in Student,
        inner_join: u in assoc(a, :user),
        where: a.id == ^id and u.id == ^user.id
    )
    |> update_student(%{name: name, email: email})
  end

  def add_groups(student, groups) do
    new_groups =
      Enum.map(groups, fn %{id: id} ->
        Repo.get(Group, String.to_integer(id)) |> Repo.preload(:students)
      end)

    merge = Enum.uniq(new_groups ++ student.groups)

    student
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:groups, merge)
    |> Repo.update!()

    {:ok, Repo.preload(student, :groups)}
  end

  def add_groups_to_student(%{student_id: id, groups: groups}, user) do
    Helpers.get_user_student(id, user)
    |> add_groups(groups)
  end

  def get_group(group_id, user) do
    Repo.one(
      from g in Group,
        inner_join: u in assoc(g, :user),
        where: g.id == ^group_id and u.id == ^user.id
    )
  end

  def get_user_group(group_id, user) do
    get_group(group_id, user)
    |> Repo.preload(:students)
  end

  def add_many_classes(student, classes) do
    new_classes =
      Enum.map(classes, fn %{id: id} ->
        Repo.get(Class, String.to_integer(id))
        |> Repo.preload(:students)
      end)

    merge = Enum.uniq(new_classes ++ student.classes)

    student
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:classes, merge)
    |> Repo.update!()

    {:ok, Repo.preload(student, :classes)}
  end

  def add_classes_to_student(%{student_id: id, classes: classes}, user) do
    Helpers.get_user_student(id, user)
    |> Repo.preload(:classes)
    |> add_many_classes(classes)
  end

  def remove_class(student, class_id) do
    # I need to change how to add and delete assosiations.
    new_groups = Enum.filter(student.classes, fn class -> class.id !== class_id end)

    student
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(
      :classes,
      new_groups
    )
    |> Repo.update!()
  end

  def delete_student_class(%{class_id: class_id, student_id: student_id}, user) do
    {id, _} = Integer.parse(class_id)

    Helpers.get_user_student(student_id, user)
    |> remove_class(id)
  end

  def delete_student_from_class(%{class_id: class_id, student_id: student_id}, user) do
    {id, _} = Integer.parse(class_id)

    Helpers.get_user_student(student_id, user)
    |> remove_class(id)

    Repo.get(Class, id) |> Repo.preload(:students)
  end

  def remove_group(student, group_id) do
    new_groups = Enum.filter(student.groups, fn g -> g.id !== group_id end)

    student
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(
      :groups,
      new_groups
    )
    |> Repo.update!()
  end

  def delete_student_group(%{group_id: group_id, student_id: student_id}, user) do
    {id, _} = Integer.parse(group_id)

    Helpers.get_user_student(student_id, user)
    |> remove_group(id)
  end

  def add_many_students_to_group_from_list(group, students_list) do
    new_students =
      Enum.map(students_list, fn %{id: id} ->
        Repo.get(Student, String.to_integer(id))
        |> Repo.preload(:groups)
      end)

    add_many_students_to_group(group, Enum.uniq(new_students ++ group.students))
  end

  def add_many_students_to_group(group, students_list) do
    group
    |> Repo.preload(:students)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:students, students_list)
    |> Repo.update!()

    {:ok, Repo.preload(group, :students)}
  end

  def add_students_to_group(%{group_id: group_id, students: students_list}, user) do
    get_user_group(group_id, user)
    |> add_many_students_to_group_from_list(students_list)
  end

  def delete_student_from_user_group(group, student_id) do
    new_students = Enum.filter(group.students, fn student -> student.id !== student_id end)

    group
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:students, new_students)
    |> Repo.update!()

    {:ok, Repo.preload(group, :students)}
  end

  def delete_student_from_group(%{group_id: group_id, student_id: student_id}, user) do
    {id, _} = Integer.parse(student_id)

    get_user_group(group_id, user)
    |> delete_student_from_user_group(id)
  end

  def get_user_student(id, user) do
    Helpers.get_user_student(id, user)
  end
end
