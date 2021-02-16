defmodule Juserver.GroupsTest do
  use Juserver.DataCase

  alias Juserver.Groups

  describe "groups" do
    alias Juserver.Groups.Group

    @valid_attrs %{cost: 120.5}
    @update_attrs %{cost: 456.7}
    @invalid_attrs %{cost: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Groups.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Groups.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Groups.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Groups.create_group(@valid_attrs)
      assert group.cost == 120.5
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, %Group{} = group} = Groups.update_group(group, @update_attrs)
      assert group.cost == 456.7
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_group(group, @invalid_attrs)
      assert group == Groups.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Groups.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Groups.change_group(group)
    end
  end

  describe "payments" do
    alias Juserver.Groups.Payment

    @valid_attrs %{amount: 120.5, month: 42}
    @update_attrs %{amount: 456.7, month: 43}
    @invalid_attrs %{amount: nil, month: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Groups.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Groups.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Groups.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = Groups.create_payment(@valid_attrs)
      assert payment.amount == 120.5
      assert payment.month == 42
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = Groups.update_payment(payment, @update_attrs)
      assert payment.amount == 456.7
      assert payment.month == 43
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_payment(payment, @invalid_attrs)
      assert payment == Groups.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Groups.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Groups.change_payment(payment)
    end
  end

  describe "affiliates" do
    alias Juserver.Groups.Affiliate

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def affiliate_fixture(attrs \\ %{}) do
      {:ok, affiliate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Groups.create_affiliate()

      affiliate
    end

    test "list_affiliates/0 returns all affiliates" do
      affiliate = affiliate_fixture()
      assert Groups.list_affiliates() == [affiliate]
    end

    test "get_affiliate!/1 returns the affiliate with given id" do
      affiliate = affiliate_fixture()
      assert Groups.get_affiliate!(affiliate.id) == affiliate
    end

    test "create_affiliate/1 with valid data creates a affiliate" do
      assert {:ok, %Affiliate{} = affiliate} = Groups.create_affiliate(@valid_attrs)
      assert affiliate.email == "some email"
      assert affiliate.name == "some name"
    end

    test "create_affiliate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_affiliate(@invalid_attrs)
    end

    test "update_affiliate/2 with valid data updates the affiliate" do
      affiliate = affiliate_fixture()
      assert {:ok, %Affiliate{} = affiliate} = Groups.update_affiliate(affiliate, @update_attrs)
      assert affiliate.email == "some updated email"
      assert affiliate.name == "some updated name"
    end

    test "update_affiliate/2 with invalid data returns error changeset" do
      affiliate = affiliate_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_affiliate(affiliate, @invalid_attrs)
      assert affiliate == Groups.get_affiliate!(affiliate.id)
    end

    test "delete_affiliate/1 deletes the affiliate" do
      affiliate = affiliate_fixture()
      assert {:ok, %Affiliate{}} = Groups.delete_affiliate(affiliate)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_affiliate!(affiliate.id) end
    end

    test "change_affiliate/1 returns a affiliate changeset" do
      affiliate = affiliate_fixture()
      assert %Ecto.Changeset{} = Groups.change_affiliate(affiliate)
    end
  end
end
