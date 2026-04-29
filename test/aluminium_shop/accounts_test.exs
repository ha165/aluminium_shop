defmodule AluminiumShop.AccountsTest do
  use AluminiumShop.DataCase

  alias AluminiumShop.Accounts
  alias AluminiumShop.Repo
  alias AluminiumShop.Accounts.Role

  describe "create_user/1" do
    setup do
      role =
        %Role{}
        |> Role.changeset(%{name: "admin"})
        |> Repo.insert!()

      %{role: role}
    end

    test "creates valid user", %{role: role} do
      attrs = %{
        first_name: "John",
        last_name: "Doe",
        phone: "0712345678",
        email: "john@test.com",
        password: "123456",
        role_id: role.id
      }

      assert {:ok, user} = Accounts.create_user(attrs)
      assert user.email == "john@test.com"
    end

    test "fails duplicate email", %{role: role} do
      attrs = %{
        first_name: "John",
        last_name: "Doe",
        phone: "0712345678",
        email: "john@test.com",
        password: "123456",
        role_id: role.id
      }

      Accounts.create_user(attrs)

      assert {:error, _changeset} =
               Accounts.create_user(%{attrs | phone: "0799999999"})
    end
  end

  describe "authenticate_user/2" do
    setup do
      role =
        %Role{}
        |> Role.changeset(%{name: "staff"})
        |> Repo.insert!()

      {:ok, user} =
        Accounts.create_user(%{
          first_name: "Jane",
          last_name: "Doe",
          phone: "0700000000",
          email: "jane@test.com",
          password: "secret123",
          role_id: role.id
        })

      %{user: user}
    end

    test "authenticates with email", %{user: user} do
      assert {:ok, found_user} =
               Accounts.authenticate_user("jane@test.com", "secret123")

      assert found_user.id == user.id
    end

    test "authenticates with phone", %{user: user} do
      assert {:ok, found_user} =
               Accounts.authenticate_user("0700000000", "secret123")

      assert found_user.id == user.id
    end

    test "fails wrong password" do
      assert {:error, :invalid_credentials} =
               Accounts.authenticate_user("jane@test.com", "wrongpass")
    end

    test "fails unknown user" do
      assert {:error, :invalid_credentials} =
               Accounts.authenticate_user("unknown@test.com", "123456")
    end
  end
end