defmodule Juserver.Repo do
  use Ecto.Repo,
    otp_app: :juserver,
    adapter: Ecto.Adapters.Postgres
end
