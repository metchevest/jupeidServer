defmodule JuserverWeb.AffiliateResolver do
  alias Juserver.Groups

  def user_affiliates(_root, %{id: id}, _info) do
    case Groups.list_user_affiliates(id) do
      nil -> {:error, "Didn't found aggiliates for the user id: #{id}"}
      list_of_affiliates -> {:ok, list_of_affiliates}
    end
  end

  def get_affiliate(_root, args, _info) do
    IO.puts("En el resolver")
    IO.inspect(args)

    case Groups.get_affilite_user(args) do
      nil -> {:error, "Affiliate not found"}
      affiliate -> {:ok, affiliate}
    end
  end

  def get_affiliate_groups(_root, args, _info) do
    case Groups.get_affiliate_groups(args) do
      nil -> {:error, "Affiliates not found for the group"}
      list_of_groups -> {:ok, list_of_groups}
    end
  end

  def get_affiliate_payments(_root, args, _info) do
    case Groups.get_affiliate_payments(args) do
      nil -> {:error, "Payments not found"}
      list_of_payments -> {:ok, list_of_payments}
    end
  end

  def create_affiliate(_root, args, _info) do
    {:ok, Groups.create_user_affiliate(args)}
  end

  def create_payment(_root, args, _info) do
    {:ok, Groups.create_user_payment(args)}
  end
end
