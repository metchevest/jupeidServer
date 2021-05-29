defmodule JuserverWeb.Schema.Types do
  alias Juserver.{Groups, Accounts}
  alias Juserver.Repo

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :user do
    field :id, :id
    field :facebook_id, :string
    field :fantasy_name, :string
    field :month_income, :float
    field :name, :string
    field :email, :string
    field :password, :string
    field :token, :string

    field :groups, list_of(:group) do
      resolve(dataloader(Groups))
    end
  end

  object :payment do
    field :id, :id
    field :amount, :float
    field :month, :integer
  end

  object :class do
    field :id, :id
    field :date, :string
    field :hour, :float
    field :name, :string
    field :activity, :string
  end

  object :affiliate do
    field :id, :id
    field :email, :string
    field :name, :string
    field :groups, list_of(:group), resolve: dataloader(Groups)
    # field :payments, list_of(:payment), resolve: assoc(:payments)
  end

  object :group do
    field :id, :id
    field :cost, :float
    field :name, :string
    # field :affiliates, list_of(:affiliate), resolve: assoc(:affiliates)
    # field :classes, list_of(:class), resolve: assoc(:classes)
    # field :payments, list_of(:payment), resolve: assoc(:payments)
  end
end
