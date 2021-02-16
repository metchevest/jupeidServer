defmodule JuserverWeb.ClassResolver do
  alias Juserver.Groups

  def all_classes(_root, %{"id" => id}, _info) do
    case Groups.list_all_classes(id) do
      nil -> {:error, "Group ID #{id} not found"}
      list -> {:ok, list}
    end
  end

  def get_class(_root, %{"id" => id}, _info) do
    case Groups.get_user_class(id) do
      nil -> {:error, "Class not found"}
      class -> {:ok, class}
    end
  end
end
