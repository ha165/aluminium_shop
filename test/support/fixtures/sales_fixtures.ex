defmodule AluminiumShop.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AluminiumShop.Sales` context.
  """

  @doc """
  Generate a quotation.
  """
  def quotation_fixture(attrs \\ %{}) do
    {:ok, quotation} =
      attrs
      |> Enum.into(%{
        status: "some status",
        total_amount: "120.5"
      })
      |> AluminiumShop.Sales.create_quotation()

    quotation
  end

  @doc """
  Generate a quotation_item.
  """
  def quotation_item_fixture(attrs \\ %{}) do
    {:ok, quotation_item} =
      attrs
      |> Enum.into(%{
        quantity: 42,
        subtotal: "120.5",
        unit_price: "120.5"
      })
      |> AluminiumShop.Sales.create_quotation_item()

    quotation_item
  end
end
