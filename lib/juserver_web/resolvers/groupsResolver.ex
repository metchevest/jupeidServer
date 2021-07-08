defmodule JuserverWeb.GroupsResolver do
  alias Juserver.Groups
  alias JuserverWeb.Checkout

  def all_groups(_args, %{context: %{current_user: current_user}}) do
    IO.puts("en el resolver de all groups")
    IO.inspect(current_user)

    case Groups.list_user_groups(current_user) do
      nil -> {:error, "there is no groups"}
      list -> {:ok, list}
    end
  end

  def all_groups(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create_group(%{name: name, cost: cost}, %{context: %{current_user: current_user}}) do
    case Groups.create_user_group(%{name: name, cost: cost, user: current_user}) do
      nil ->
        {:error, "could not create the group"}

      group ->
        IO.inspect(group)
        {:ok, group}
    end
  end

  def create_group(_args, _info) do
    {:error, "Not Authorized"}
  end

  def get_user_group(%{id: id}, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.get_user_group(id, current_user))
  end

  def get_user_group(_args, _info) do
    {:error, "Not Authorized"}
  end

  def get_group_classes(%{user_id: user_id, id: id}, %{context: %{current_user: current_user}}) do
    case Groups.get_group_classes(user_id, id) do
      nil -> {:error, "Classes not found for the user and group"}
      list -> {:ok, list}
    end
  end

  def get_group_classes(_args, _info) do
    {:error, "Not Authorized"}
  end

  def get_group_students(args, %{context: %{current_user: current_user}}) do
    case Groups.get_group_students(args) do
      nil -> {:error, "Students not found for the user and group"}
      list -> {:ok, list}
    end
  end

  def get_group_students(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_group(args, %{context: %{current_user: current_user}}) do
    case Groups.delete_user_group(args) do
      {:error, _} ->
        {:error, "Group not found"}

      {:ok, group} ->
        {:ok, group}
    end
  end

  def delete_group(_args, _info) do
    {:error, "Not Authorized"}
  end

  def edit_user_group(%{id: id, name: name, cost: cost}, %{context: %{current_user: current_user}}) do
    IO.puts("Estoy editando el grupo")

    case Groups.edit_user_group(%{id: id, name: name, cost: cost, user: current_user}) do
      {:error, _} -> {:error, "Error"}
      {:ok, group} -> {:ok, group}
    end
  end

  def edit_user_group(_args, _info) do
    {:error, "Not Authorized"}
  end

  def edit_user_assistant(%{id: id, name: name, email: email}, %{
        context: %{current_user: current_user}
      }) do
    IO.puts("estoy en el resolver")

    case Groups.edit_user_student(%{id: id, name: name, email: email, user: current_user}) do
      {:error, _} -> {:error, "Error"}
      {:ok, student} -> {:ok, student}
    end
  end

  def edit_user_assistant(_args, _info) do
    {:error, "Not Authorized"}
  end

  def add_students_to_group(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.add_students_to_group(args, current_user))
  end

  def add_students_to_group(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_student_from_group(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.delete_student_from_group(args, current_user))
  end

  def delete_student_from_group(_args, _info) do
    {:error, "Not Authorized"}
  end
end
