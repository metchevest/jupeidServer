defmodule JuserverWeb.Schema do
  use Absinthe.Schema
  alias Juserver.{Groups, Accounts, Activities, Payments}

  import_types(Absinthe.Type.Custom)

  import_types(JuserverWeb.Schema.Types)

  alias JuserverWeb.{
    GroupsResolver,
    ClassResolver,
    StudentResolver,
    UserResolver,
    PaymentResolver
  }

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Groups, Groups.data())
      |> Dataloader.add_source(Activities, Activities.data())
      |> Dataloader.add_source(Payments, Payments.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "List all users in the system, this is for test only"
    field :all_users, list_of(:user) do
      resolve(&UserResolver.all_users/3)
    end

    @desc "User information after login"
    field :profile, :user do
      resolve(&UserResolver.profile/2)
    end

    @desc "List all the user's groups"
    field :groups, non_null(list_of(non_null(:group))) do
      resolve(&GroupsResolver.all_groups/2)
    end

    @desc "Get a user's group"
    field :group, :group do
      arg(:id, non_null(:id))
      resolve(&GroupsResolver.get_user_group/2)
    end

    @desc "List all the user's assistants"
    field :students, non_null(list_of(non_null(:student))) do
      resolve(&StudentResolver.all_students/2)
    end

    @desc "Get a user's assitant"
    field :student, :student do
      arg(:id, non_null(:id))
      resolve(&StudentResolver.get_user_student/2)
    end

    @desc "List all the user's classes"
    field :classes, list_of(:class) do
      resolve(&ClassResolver.all_classes/2)
    end

    @desc "Get a user's class"
    field :class, :class do
      arg(:id, non_null(:id))
      resolve(&ClassResolver.get_user_class/2)
    end

    @desc "Get user's payments"
    field :payments, list_of(:payment) do
      resolve(&PaymentResolver.all_user_payments/2)
    end
  end

  mutation do
    @desc "Sign up a new user"
    field :signup, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&UserResolver.signUp/2)
    end

    @desc "Log in"
    field :log_in, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&UserResolver.logIn/2)

      middleware(fn res, _ ->
        with %{value: %{user: user, token: token}} <- res do
          next_context =
            res.context
            |> Map.put(:current_user, user)
            |> Map.put(:access_token, token)

          %{res | context: next_context}
        end
      end)
    end

    @desc "Log out"
    field :log_out, :user do
      resolve(&UserResolver.logout/2)
    end

    @desc "Set tour"
    field :tour, :user do
      arg(:tour, :boolean)
      resolve(&UserResolver.set_user_tour/2)
    end

    @desc "Create a new group"
    field :create_group, :group do
      arg(:cost, non_null(:float))
      arg(:name, non_null(:string))
      resolve(&GroupsResolver.create_group/2)
    end

    @desc "Create a new student"
    field :create_student, :student do
      arg(:email, :string)
      arg(:name, non_null(:string))
      resolve(&StudentResolver.create_student/2)
    end

    @desc "Create a new Class"
    field :create_class, :class do
      arg(:date, non_null(:string))
      arg(:hour, non_null(:float))
      arg(:name, non_null(:string))
      arg(:activity, :string)
      resolve(&ClassResolver.create_user_class/2)
    end

    @desc "Create a new payment for an student"
    field :create_payment, :student do
      arg(:student_id, non_null(:id))
      arg(:month, non_null(:integer))
      arg(:year, non_null(:integer))
      resolve(&PaymentResolver.create_payment/2)
    end

    @desc "Delete a group"
    field :delete_group, :group do
      arg(:id, non_null(:id))
      resolve(&GroupsResolver.delete_group/2)
    end

    @desc "Delete a class"
    field :delete_class, :class do
      arg(:id, non_null(:id))
      resolve(&ClassResolver.delete_class/2)
    end

    @desc "Delete a Student"
    field :delete_student, :student do
      arg(:id, non_null(:id))
      resolve(&StudentResolver.delete_user_student/2)
    end

    @desc "Edit a group"
    field :edit_group, :group do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:cost, :float)
      resolve(&GroupsResolver.edit_user_group/2)
    end

    @desc "Edit a class"
    field :edit_class, :class do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:hour, :float)
      arg(:activity, :string)
      arg(:date, :string)
      resolve(&ClassResolver.edit_user_class/2)
    end

    @desc "Edit a student"
    field :edit_student, :student do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)
      resolve(&GroupsResolver.edit_user_assistant/2)
    end

    @desc "Add Students to Group"
    field :add_students_to_group, :group do
      arg(:group_id, non_null(:id))
      arg(:students, list_of(:student_input))
      resolve(&GroupsResolver.add_students_to_group/2)
    end

    @desc "Add Students to Class"
    field :add_students_to_class, :class do
      arg(:class_id, non_null(:id))
      arg(:students, list_of(:student_input))
      resolve(&ClassResolver.add_students_to_class/2)
    end

    @desc "Add groups to a Student"
    field :add_student_groups, :student do
      arg(:student_id, non_null(:id))
      arg(:groups, list_of(:group_input))
      resolve(&StudentResolver.add_student_groups/2)
    end

    @desc "Add classes to a Student"
    field :add_student_classes, :student do
      arg(:student_id, non_null(:id))
      arg(:classes, list_of(:class_input))
      resolve(&StudentResolver.add_student_classes/2)
    end

    @desc "Delete a Class from a Student"
    field :delete_class_from_student, :student do
      arg(:student_id, non_null(:id))
      arg(:class_id, non_null(:id))
      resolve(&StudentResolver.delete_class_from_student/2)
    end

    @desc "Delete a Group from a Student"
    field :delete_group_from_student, :student do
      arg(:student_id, non_null(:id))
      arg(:group_id, non_null(:id))
      resolve(&StudentResolver.delete_student_from_group/2)
    end

    # This is the same mutation than :delete_student_group but the return
    # is different so the Apollo's cache update itself ?
    @desc "Delete a Student from a Group"
    field :delete_student_from_group, :group do
      arg(:group_id, non_null(:id))
      arg(:student_id, non_null(:id))
      resolve(&GroupsResolver.delete_student_from_group/2)
    end

    # The same case as above
    @desc "Delete a Student from a Class"
    field :delete_student_from_class, :class do
      arg(:student_id, non_null(:id))
      arg(:class_id, non_null(:id))
      resolve(&StudentResolver.delete_student_from_class/2)
    end

    # This mutation may be used to replace "create_payment" with a list of one student
    @desc "Add a payment to many Student"
    field :create_many_payments, list_of(:student) do
      arg(:students, list_of(:student_input))
      resolve(&PaymentResolver.create_many_payments/2)
    end
  end
end
