defmodule AluminiumShop.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AluminiumShop.Inventory` context.
  """

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        location: "some location",
        quantity: 42
      })
      |> AluminiumShop.Inventory.create_stock()

    stock
  end

  @doc """
  Generate a stock_movement.
  """
  def stock_movement_fixture(attrs \\ %{}) do
    {:ok, stock_movement} =
      attrs
      |> Enum.into(%{
        quantity: 42,
        reason: "some reason",
        type: "some type"
      })
      |> AluminiumShop.Inventory.create_stock_movement()

    stock_movement
  end
end
