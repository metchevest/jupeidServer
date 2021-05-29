defmodule JuserverWeb.ClassResolver do
  alias Juserver.Activities
  alias JuserverWeb.Checkout

  def all_classes(_args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Activities.list_user_classes(current_user))
  end

  def all_classes(_args, _info) do
    {:error, "Not Authorized."}
  end

  def get_class(%{id: id}, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Activities.get_user_class(current_user, id))
  end

  def get_class(_args, _info) do
    {:error, "Not Authorized."}
  end

  def create_user_class(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(
      Activities.create_user_class(Map.merge(args, %{current_user: current_user}))
    )
  end

  def create_user_class(_args, _info) do
    {:error, "Not Authorized."}
  end

  def delete_class(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(
      Activities.delete_user_class(Map.merge(args, %{current_user: current_user}))
    )
  end

  def delete_class(_args, _info) do
    {:error, "Not Authorized."}
  end

  def edit_user_class(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(
      Activities.update_user_class(Map.merge(args, %{current_user: current_user}))
    )
  end

  def edit_user_class(_args, _info) do
    {:error, "Not Authorized."}
  end
end
