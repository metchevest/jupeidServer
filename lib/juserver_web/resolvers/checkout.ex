defmodule JuserverWeb.Checkout do
  def checkout_response({:error, _msg}) do
    IO.puts("Cheking out 1")
    {:error, "Not now."}
  end

  def checkout_response([]) do
    IO.puts("Cheking out 2")
    {:ok, []}
  end

  def checkout_response(nil) do
    IO.puts("Cheking out 3")
    {:error, "Response from checkut"}
  end

  def checkout_response({:ok, object}) do
    IO.puts("Cheking out 4")
    {:ok, object}
  end

  def checkout_response(object) do
    IO.puts("Cheking out 5")
    {:ok, object}
  end
end
