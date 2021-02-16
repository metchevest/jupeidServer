defmodule Juserver.ActivitiesTest do
  use Juserver.DataCase

  alias Juserver.Activities

  describe "classes" do
    alias Juserver.Activities.Class

    @valid_attrs %{activity: "some activity", day: "some day", hour: 42}
    @update_attrs %{activity: "some updated activity", day: "some updated day", hour: 43}
    @invalid_attrs %{activity: nil, day: nil, hour: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activities.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Activities.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Activities.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Activities.create_class(@valid_attrs)
      assert class.activity == "some activity"
      assert class.day == "some day"
      assert class.hour == 42
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, %Class{} = class} = Activities.update_class(class, @update_attrs)
      assert class.activity == "some updated activity"
      assert class.day == "some updated day"
      assert class.hour == 43
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_class(class, @invalid_attrs)
      assert class == Activities.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Activities.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Activities.change_class(class)
    end
  end
end
