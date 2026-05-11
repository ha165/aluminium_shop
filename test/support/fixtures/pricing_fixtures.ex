defmodule AluminiumShop.PricingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AluminiumShop.Pricing` context.
  """

  @doc """
  Generate a product_price.
  """
  def product_price_fixture(attrs \\ %{}) do
    {:ok, product_price} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        effective_from: ~U[2026-05-10 11:19:00Z],
        price: "120.5",
        product_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> AluminiumShop.Pricing.create_product_price()

    product_price
  end
end
