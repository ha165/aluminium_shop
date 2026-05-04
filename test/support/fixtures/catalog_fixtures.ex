defmodule AluminiumShop.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AluminiumShop.Catalog` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name",
        parent_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> AluminiumShop.Catalog.create_category()

    category
  end

  @doc """
  Generate a unique product sku.
  """
  def unique_product_sku, do: "some sku#{System.unique_integer([:positive])}"

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        sku: unique_product_sku()
      })
      |> AluminiumShop.Catalog.create_product()

    product
  end
end
