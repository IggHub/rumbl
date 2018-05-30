defmodule Rumbl.UserTest do
  use Rumbl.ModelCase, async: true
  alias Rumbl.User

  @valid_attrs %{name: "iggy", username: "iggy", password: "secret"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset that does not accept username that is too long" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 100))
    assert {:username, {"should be at most %{count} character(s)", [count: 20]}} in errors_on(%Users{}, attrs)
  end
end
