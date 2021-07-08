defmodule JuserverWeb.PaymentResolver do
  alias Juserver.Payments
  alias JuserverWeb.Checkout

  def all_user_payments(_args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Payments.get_user_payments(current_user))
  end

  def all_user_payments(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create_payment(%{student_id: student_id, month: month, year: year}, %{
        context: %{current_user: current_user}
      }) do
    {id, _} = Integer.parse(student_id)

    Checkout.checkout_response(
      Payments.create_user_payment(%{student_id: id, month: month, year: year}, current_user)
    )
  end

  def create_payment(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create_many_payments(args, %{context: %{current_user: current_user}}) do
    Checkout.checkout_response(Payments.create_many_user_payments(args, current_user))
  end

  def create_many_payments(_args, _info) do
    {:error, "Not Authorized"}
  end
end
