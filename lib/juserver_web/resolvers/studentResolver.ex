defmodule JuserverWeb.StudentResolver do
  alias Juserver.Groups
  alias JuserverWeb.Checkout

  def all_students(_args, %{context: %{current_user: current_user}}) do
    case Groups.list_user_students(current_user) do
      nil -> {:error, "Didn't found students"}
      list_of_students -> {:ok, list_of_students}
    end
  end

  def all_students(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create_student(%{name: name, email: email}, %{
        context: %{current_user: current_user}
      }) do
    case Groups.create_user_student(%{user: current_user, name: name, email: email}) do
      nil -> {:error, "Not now."}
      student -> {:ok, student}
    end
  end

  def create_student(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_user_student(%{id: id}, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.delete_user_student(id, current_user))
  end

  def delete_user_student(_args, _info) do
    {:error, "Not Authorized"}
  end

  def get_user_student(%{id: id}, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.get_user_student(id, current_user))
  end

  def get_user_student(_args, _info) do
    {:error, "Not Authorized"}
  end

  def add_student_groups(args, %{context: %{current_user: current_user}}) do
    IO.puts("llegue al Resolver...")
    IO.inspect(args)
    Groups.add_groups_to_student(args, current_user)
  end

  def add_student_groups(_args, _info) do
    {:error, "Not Authorized"}
  end

  def add_student_classes(args, %{context: %{current_user: current_user}}) do
    Groups.add_classes_to_student(args, current_user)
  end

  def add_student_classes(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_student_from_class(args, %{context: %{current_user: current_user}}) do
    # I need to return a Class
    Checkout.checkout_response(Groups.delete_student_from_class(args, current_user))
  end

  def delete_student_from_class(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_class_from_student(args, %{context: %{current_user: current_user}}) do
    # I need to return a Student
    Checkout.checkout_response(Groups.delete_student_class(args, current_user))
  end

  def delete_class_from_student(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_student_from_group(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.delete_student_group(args, current_user))
  end

  def delete_student_group(_args, _info) do
    {:error, "Not Authorized"}
  end
end
