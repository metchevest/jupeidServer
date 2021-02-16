defmodule JuserverWeb.GroupsResolver do
  alias Juserver.Groups

  def user_groups(_root, args, _info) do
    IO.puts("aca estamos")
    IO.inspect(args)

    case Groups.list_user_groups(args) do
      nil -> {:error, "could not create the group"}
      list -> {:ok, list}
    end
  end

  def all_groups(_root, _args, _info) do
    case Groups.list_groups() do
      nil -> {:error, "there is no groups"}
      list -> {:ok, list}
    end
  end

  def create_group(_root, args, _info) do
    case Groups.create_user_group(args) do
      nil -> {:error, "could not create the group"}
      group -> {:ok, group}
    end
  end

  def get_group(_root, %{id: id}, _info) do
    case Groups.get_group!(id) do
      nil ->
        {:error, "Group ID #{id} not found"}

      group ->
        {:ok, group}
    end
  end

  def get_group_classes(_root, %{user_id: user_id, id: id}, _info) do
    case Groups.get_group_classes(user_id, id) do
      nil -> {:error, "Classes not found for the user and group"}
      list -> {:ok, list}
    end
  end

  def get_group_affiliates(_root, args, _info) do
    case Groups.get_group_affiliates(args) do
      nil -> {:error, "Affiliates not found for the user and group"}
      list -> {:ok, list}
    end
  end

  def delete_group(_root, args, _info) do
    case Groups.delete_user_group(args) do
      {:error, _} -> {:error, "Group not found"}
      {:ok, group} -> {:ok, group}
    end
  end
end
