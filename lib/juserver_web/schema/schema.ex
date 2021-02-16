defmodule JuserverWeb.Schema do
  use Absinthe.Schema
  alias Juserver.{Groups, Accounts}

  # In case I need to use date and times :naive_datetime
  # import_types Absinthe.Type.Custom

  import_types(JuserverWeb.Schema.Types)

  alias JuserverWeb.{GroupsResolver, ClassResolver, AffiliateResolver, UserResolver}

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Groups, Groups.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    # This should be deleted in production
    field :all_users, list_of(:user) do
      resolve(&UserResolver.all_users/3)
    end

    # This should be deleted in production
    field :all_groups, non_null(list_of(non_null(:group))) do
      resolve(&GroupsResolver.all_groups/3)
    end

    field :all_classes, non_null(list_of(non_null(:class))) do
      arg(:id, non_null(:id))
      resolve(&ClassResolver.all_classes/3)
    end

    # field :user_groups, non_null(list_of(non_null(:group))) do
    #   arg(:id, non_null(:id))
    #   resolve(&GroupsResolver.user_groups/3)
    # end

    field :user_affiliates, non_null(list_of(non_null(:affiliate))) do
      arg(:id, non_null(:id))
      resolve(&AffiliateResolver.user_affiliates/3)
    end

    field :get_group, :group do
      arg(:id, non_null(:id))
      resolve(&GroupsResolver.get_group/3)
    end

    field :get_affiliate, :affiliate do
      arg(:user_id, non_null(:id))
      arg(:id, non_null(:id))
      resolve(&AffiliateResolver.get_affiliate/3)
    end

    field :get_class, :class do
      arg(:id, non_null(:id))
      resolve(&ClassResolver.get_class/3)
    end

    # field :get_group_classes, list_of(non_null(:class)) do
    #   arg(:user_id, non_null(:id))
    #   arg(:id, non_null(:id))
    #   resolve(&GroupsResolver.get_group_classes/3)
    # end

    # field :get_group_affiliates, list_of(non_null(:affiliate)) do
    #   arg(:id, non_null(:id))
    #   resolve(&GroupsResolver.get_group_affiliates/3)
    # end

    # field :get_affiliate_groups, list_of(non_null(:group)) do
    #   arg(:id, non_null(:id))
    #   resolve(&AffiliateResolver.get_affiliate_groups/3)
    # end

    # field :get_affiliate_payments, list_of(non_null(:payment)) do
    #   arg(:id, non_null(:id))
    #   resolve(&AffiliateResolver.get_affiliate_payments/3)
    # end
  end

  mutation do
    @desc "Sign a new user"
    field :signup, :user do
      arg(:email, non_null(:string))
      resolve(&UserResolver.signup/3)
    end

    @desc "Sign in"
    field :sign_in, :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&UserResolver.signin/3)
    end

    @desc "Log out"
    field :log_out, :user do
      arg(:email, non_null(:string))
      resolve(&UserResolver.logout/3)
    end

    @desc "Create a new group"
    field :create_group, :group do
      arg(:user_id, non_null(:id))
      arg(:cost, non_null(:float))
      resolve(&GroupsResolver.create_group/3)
    end

    @desc "Create a new affiliate"
    field :create_affiliate, :affiliate do
      arg(:user_id, non_null(:id))
      arg(:group_id, non_null(:id))
      # TO-DO invetigate if there's a custom type for emails
      arg(:email, :string)
      arg(:name, non_null(:string))
      resolve(&AffiliateResolver.create_affiliate/3)
    end

    @desc "Create a new payment for an affiliate"
    field :create_payment, :payment do
      arg(:affiliate_id, non_null(:id))
      arg(:group_id, non_null(:id))
      arg(:amount, non_null(:float))
      arg(:month, non_null(:integer))
      resolve(&AffiliateResolver.create_payment/3)
    end

    @desc "Delete a group"
    field :delete_group, :group do
      arg(:id, non_null(:id))
      resolve(&GroupsResolver.delete_group/3)
    end
  end
end
