defmodule JuserverWeb.Schema.Types do
  alias Juserver.{Groups, Activities, Payments}

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  import Absinthe.Type.Custom

  # scalar :datetime, name: "DateTime" do
  #   serialize(&DateTime.to_iso8601/1)
  #   parse(&parse_datetime/1)
  # end

  object :user do
    field :id, :id
    field :facebook_id, :string
    field :fantasy_name, :string
    field :month_income, :float
    field :name, :string
    field :email, :string
    field :password, :string
    field :token, :string
    field :tour, :boolean

    field :groups, list_of(:group) do
      resolve(dataloader(Groups))
    end
  end

  object :payment do
    field :id, :id
    field :month, :integer
    field :year, :integer
    field :payment_date, :datetime
    field :student, :student
  end

  object :class do
    field :id, :id
    field :date, :string
    field :hour, :float
    field :name, :string
    field :activity, :string
    field :students, list_of(:student), resolve: dataloader(Activities)
  end

  object :student do
    field :id, :id
    field :email, :string
    field :name, :string
    field :groups, list_of(:group), resolve: dataloader(Groups)
    field :payments, list_of(:payment), resolve: dataloader(Payments)
    field :classes, list_of(:class), resolve: dataloader(Groups)
  end

  object :group do
    field :id, :id
    field :cost, :float
    field :name, :string
    field :students, list_of(:student), resolve: dataloader(Groups)
  end

  input_object :filter_class do
    field :id, :id
  end

  # Let's decide if this is needed.
  input_object :group_input do
    field :id, :id
  end

  input_object :class_input do
    field :id, :id
  end

  input_object :student_input do
    field :id, :id
  end
end
