defmodule AluminiumShop.SalesTest do
  use AluminiumShop.DataCase

  alias AluminiumShop.Sales

  describe "quotations" do
    alias AluminiumShop.Sales.Quotation

    import AluminiumShop.SalesFixtures

    @invalid_attrs %{status: nil, total_amount: nil}

    test "list_quotations/0 returns all quotations" do
      quotation = quotation_fixture()
      assert Sales.list_quotations() == [quotation]
    end

    test "get_quotation!/1 returns the quotation with given id" do
      quotation = quotation_fixture()
      assert Sales.get_quotation!(quotation.id) == quotation
    end

    test "create_quotation/1 with valid data creates a quotation" do
      valid_attrs = %{status: "some status", total_amount: "120.5"}

      assert {:ok, %Quotation{} = quotation} = Sales.create_quotation(valid_attrs)
      assert quotation.status == "some status"
      assert quotation.total_amount == Decimal.new("120.5")
    end

    test "create_quotation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_quotation(@invalid_attrs)
    end

    test "update_quotation/2 with valid data updates the quotation" do
      quotation = quotation_fixture()
      update_attrs = %{status: "some updated status", total_amount: "456.7"}

      assert {:ok, %Quotation{} = quotation} = Sales.update_quotation(quotation, update_attrs)
      assert quotation.status == "some updated status"
      assert quotation.total_amount == Decimal.new("456.7")
    end

    test "update_quotation/2 with invalid data returns error changeset" do
      quotation = quotation_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_quotation(quotation, @invalid_attrs)
      assert quotation == Sales.get_quotation!(quotation.id)
    end

    test "delete_quotation/1 deletes the quotation" do
      quotation = quotation_fixture()
      assert {:ok, %Quotation{}} = Sales.delete_quotation(quotation)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_quotation!(quotation.id) end
    end

    test "change_quotation/1 returns a quotation changeset" do
      quotation = quotation_fixture()
      assert %Ecto.Changeset{} = Sales.change_quotation(quotation)
    end
  end

  describe "quotation_items" do
    alias AluminiumShop.Sales.QuotationItem

    import AluminiumShop.SalesFixtures

    @invalid_attrs %{quantity: nil, unit_price: nil, subtotal: nil}

    test "list_quotation_items/0 returns all quotation_items" do
      quotation_item = quotation_item_fixture()
      assert Sales.list_quotation_items() == [quotation_item]
    end

    test "get_quotation_item!/1 returns the quotation_item with given id" do
      quotation_item = quotation_item_fixture()
      assert Sales.get_quotation_item!(quotation_item.id) == quotation_item
    end

    test "create_quotation_item/1 with valid data creates a quotation_item" do
      valid_attrs = %{quantity: 42, unit_price: "120.5", subtotal: "120.5"}

      assert {:ok, %QuotationItem{} = quotation_item} = Sales.create_quotation_item(valid_attrs)
      assert quotation_item.quantity == 42
      assert quotation_item.unit_price == Decimal.new("120.5")
      assert quotation_item.subtotal == Decimal.new("120.5")
    end

    test "create_quotation_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_quotation_item(@invalid_attrs)
    end

    test "update_quotation_item/2 with valid data updates the quotation_item" do
      quotation_item = quotation_item_fixture()
      update_attrs = %{quantity: 43, unit_price: "456.7", subtotal: "456.7"}

      assert {:ok, %QuotationItem{} = quotation_item} =
               Sales.update_quotation_item(quotation_item, update_attrs)

      assert quotation_item.quantity == 43
      assert quotation_item.unit_price == Decimal.new("456.7")
      assert quotation_item.subtotal == Decimal.new("456.7")
    end

    test "update_quotation_item/2 with invalid data returns error changeset" do
      quotation_item = quotation_item_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_quotation_item(quotation_item, @invalid_attrs)

      assert quotation_item == Sales.get_quotation_item!(quotation_item.id)
    end

    test "delete_quotation_item/1 deletes the quotation_item" do
      quotation_item = quotation_item_fixture()
      assert {:ok, %QuotationItem{}} = Sales.delete_quotation_item(quotation_item)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_quotation_item!(quotation_item.id) end
    end

    test "change_quotation_item/1 returns a quotation_item changeset" do
      quotation_item = quotation_item_fixture()
      assert %Ecto.Changeset{} = Sales.change_quotation_item(quotation_item)
    end
  end
end
