defmodule JuserverWeb.AffiliateResolver do
  alias Juserver.Groups
  alias JuserverWeb.Checkout

  def all_affiliates(_args, %{context: %{current_user: current_user}}) do
    case Groups.list_user_affiliates(current_user) do
      nil -> {:error, "Didn't found affiliates"}
      list_of_affiliates -> {:ok, list_of_affiliates}
    end
  end

  def all_affiliates(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create_affiliate(%{name: name, email: email}, %{
        context: %{current_user: current_user}
      }) do
    case Groups.create_user_affiliate(%{user: current_user, name: name, email: email}) do
      nil -> {:error, "Not now."}
      affiliate -> {:ok, affiliate}
    end
  end

  def create_affiliate(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_user_affiliate(%{id: id}, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Groups.delete_user_affiliate(id, current_user))
  end

  def delete_user_affiliate(_args, _info) do
    {:error, "Not Authorized"}
  end
end
