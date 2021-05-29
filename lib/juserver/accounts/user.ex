defmodule Juserver.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Juserver.Groups.{Group, Affiliate}
  alias Juserver.Activities.Class

  schema "users" do
    field :facebook_id, :string
    field :fantasy_name, :string
    field :month_income, :float
    field :name, :string
    field :email, :string
    field :password, :string
    field :token, :string

    has_many :groups, Group
    has_many :affiliates, Affiliate
    has_many :classes, Class

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :facebook_id, :fantasy_name, :month_income, :email, :password, :token])
    |> validate_required([:email, :password])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  def store_token_changeset(%Juserver.Accounts.User{} = user, attrs) do
    user
    |> cast(attrs, [:token])
  end
end
