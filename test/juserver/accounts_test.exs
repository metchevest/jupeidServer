defmodule Juserver.AccountsTest do
  use Juserver.DataCase

  alias Juserver.Accounts
  alias Juserver.Groups.Group

  describe "users" do
    alias Juserver.Accounts.User

    @valid_attrs %{
      facebook_id: "some facebook_id",
      fantasy_name: "some fantasy_name",
      month_income: 120.5,
      name: "some name",
      password: "some pass"
    }
    @update_attrs %{
      facebook_id: "some updated facebook_id",
      fantasy_name: "some updated fantasy_name",
      month_income: 456.7,
      name: "some updated name"
    }
    @invalid_attrs %{facebook_id: nil, fantasy_name: nil, month_income: nil, name: nil}

    @valid_group %{
      cost: 1800
    }

    @valid_group_cost 1800

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "new_group_to_user association with groups" do
      user = user_fixture()

      assert (%Group{} = group) = Accounts.new_group_to_user(user, @valid_group)

      assert group.cost == @valid_group_cost
    end

    # This two tests are for the validation, Guardian.
    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert {:ok, user} == Argon2.check_pass(user, "some password", hash_key: :password)
      assert user.username == "some username"
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert {:ok, user} == Argon2.check_pass(user, "some updated password", hash_key: :password)
      assert user.username == "some updated username"
    end
  end
end
