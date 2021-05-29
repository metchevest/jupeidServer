defmodule JuserverWeb.Checkout do
  def checkout_response({:error, _msg}) do
    {:error, "Not now."}
  end

  def checkout_response([]) do
    {:ok, []}
  end

  def checkout_response(nil) do
    {:error, "Not like this."}
  end

  def checkout_response({:ok, object}) do
    {:ok, object}
  end

  def checkout_response(object) do
    {:ok, object}
  end
end
