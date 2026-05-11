defmodule AluminiumShop.PricingTest do
  use AluminiumShop.DataCase

  alias AluminiumShop.Pricing

  describe "product_prices" do
    alias AluminiumShop.Pricing.ProductPrice

    import AluminiumShop.PricingFixtures

    @invalid_attrs %{currency: nil, product_id: nil, price: nil, effective_from: nil}

    test "list_product_prices/0 returns all product_prices" do
      product_price = product_price_fixture()
      assert Pricing.list_product_prices() == [product_price]
    end

    test "get_product_price!/1 returns the product_price with given id" do
      product_price = product_price_fixture()
      assert Pricing.get_product_price!(product_price.id) == product_price
    end

    test "create_product_price/1 with valid data creates a product_price" do
      valid_attrs = %{
        currency: "some currency",
        product_id: "7488a646-e31f-11e4-aace-600308960662",
        price: "120.5",
        effective_from: ~U[2026-05-10 11:19:00Z]
      }

      assert {:ok, %ProductPrice{} = product_price} = Pricing.create_product_price(valid_attrs)
      assert product_price.currency == "some currency"
      assert product_price.product_id == "7488a646-e31f-11e4-aace-600308960662"
      assert product_price.price == Decimal.new("120.5")
      assert product_price.effective_from == ~U[2026-05-10 11:19:00Z]
    end

    test "create_product_price/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pricing.create_product_price(@invalid_attrs)
    end

    test "update_product_price/2 with valid data updates the product_price" do
      product_price = product_price_fixture()

      update_attrs = %{
        currency: "some updated currency",
        product_id: "7488a646-e31f-11e4-aace-600308960668",
        price: "456.7",
        effective_from: ~U[2026-05-11 11:19:00Z]
      }

      assert {:ok, %ProductPrice{} = product_price} =
               Pricing.update_product_price(product_price, update_attrs)

      assert product_price.currency == "some updated currency"
      assert product_price.product_id == "7488a646-e31f-11e4-aace-600308960668"
      assert product_price.price == Decimal.new("456.7")
      assert product_price.effective_from == ~U[2026-05-11 11:19:00Z]
    end

    test "update_product_price/2 with invalid data returns error changeset" do
      product_price = product_price_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Pricing.update_product_price(product_price, @invalid_attrs)

      assert product_price == Pricing.get_product_price!(product_price.id)
    end

    test "delete_product_price/1 deletes the product_price" do
      product_price = product_price_fixture()
      assert {:ok, %ProductPrice{}} = Pricing.delete_product_price(product_price)
      assert_raise Ecto.NoResultsError, fn -> Pricing.get_product_price!(product_price.id) end
    end

    test "change_product_price/1 returns a product_price changeset" do
      product_price = product_price_fixture()
      assert %Ecto.Changeset{} = Pricing.change_product_price(product_price)
    end
  end
end
