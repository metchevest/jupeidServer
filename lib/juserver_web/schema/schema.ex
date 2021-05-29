defmodule JuserverWeb.Schema do
  use Absinthe.Schema
  alias Juserver.{Groups, Accounts, Activities}

  # In case I need to use date and times :naive_datetime
  # import_types Absinthe.Type.Custom

  import_types(JuserverWeb.Schema.Types)

  alias JuserverWeb.{GroupsResolver, ClassResolver, AffiliateResolver, UserResolver}

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Groups, Groups.data())
      |> Dataloader.add_source(Activities, Activities.data())

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
    field :get_group, :group do
      arg(:id, non_null(:id))
      resolve(&GroupsResolver.get_group/3)
    end

    @desc "List all the user's assistants"
    field :assistants, non_null(list_of(non_null(:affiliate))) do
      resolve(&AffiliateResolver.all_affiliates/2)
    end

    @desc "Get a user's assitant"
    field :get_assistant, :affiliate do
      arg(:user_id, non_null(:id))
      arg(:id, non_null(:id))
      resolve(&AffiliateResolver.get_affiliate/3)
    end

    @desc "List all the user's classes"
    field :classes, non_null(list_of(non_null(:class))) do
      resolve(&ClassResolver.all_classes/2)
    end

    @desc "Get a user's class"
    field :get_class, :class do
      arg(:id, non_null(:id))
      resolve(&ClassResolver.get_class/2)
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

    @desc "Create a new group"
    field :create_group, :group do
      arg(:cost, non_null(:float))
      arg(:name, non_null(:string))
      resolve(&GroupsResolver.create_group/2)
    end

    @desc "Create a new affiliate"
    field :create_assistant, :affiliate do
      arg(:email, :string)
      arg(:name, non_null(:string))
      resolve(&AffiliateResolver.create_affiliate/2)
    end

    @desc "Create a new payment for an affiliate"
    field :create_payment, :payment do
      arg(:affiliate_id, non_null(:id))
      arg(:group_id, non_null(:id))
      arg(:amount, non_null(:float))
      arg(:month, non_null(:integer))
      resolve(&AffiliateResolver.create_payment/3)
    end

    @desc "Create a new Class"
    field :create_class, :class do
      arg(:date, non_null(:string))
      arg(:hour, non_null(:float))
      arg(:name, non_null(:string))
      arg(:activity, :string)
      resolve(&ClassResolver.create_user_class/2)
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

    @desc "Delete an Assistant"
    field :delete_assistant, :affiliate do
      arg(:id, non_null(:id))
      resolve(&AffiliateResolver.delete_user_affiliate/2)
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

    @desc "Edit a affiliate"
    field :edit_assistant, :affiliate do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)
      resolve(&GroupsResolver.edit_user_assistant/2)
    end
  end
end
