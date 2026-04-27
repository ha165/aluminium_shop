defmodule AluminiumShop.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AluminiumShop.Accounts` context.
  """

  @doc """
  Generate a unique role name.
  """
  def unique_role_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: unique_role_name()
      })
      |> AluminiumShop.Accounts.create_role()

    role
  end

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        hashed_password: "some hashed_password"
      })
      |> AluminiumShop.Accounts.create_user()

    user
  end
end
