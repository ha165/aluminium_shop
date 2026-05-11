defmodule AluminiumShop.InventoryTest do
  use AluminiumShop.DataCase

  alias AluminiumShop.Inventory

  describe "inventories" do
    alias AluminiumShop.Inventory.Stock

    import AluminiumShop.InventoryFixtures

    @invalid_attrs %{location: nil, quantity: nil}

    test "list_inventories/0 returns all inventories" do
      stock = stock_fixture()
      assert Inventory.list_inventories() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Inventory.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{location: "some location", quantity: 42}

      assert {:ok, %Stock{} = stock} = Inventory.create_stock(valid_attrs)
      assert stock.location == "some location"
      assert stock.quantity == 42
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{location: "some updated location", quantity: 43}

      assert {:ok, %Stock{} = stock} = Inventory.update_stock(stock, update_attrs)
      assert stock.location == "some updated location"
      assert stock.quantity == 43
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_stock(stock, @invalid_attrs)
      assert stock == Inventory.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Inventory.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Inventory.change_stock(stock)
    end
  end

  describe "stock_movements" do
    alias AluminiumShop.Inventory.StockMovement

    import AluminiumShop.InventoryFixtures

    @invalid_attrs %{reason: nil, type: nil, quantity: nil}

    test "list_stock_movements/0 returns all stock_movements" do
      stock_movement = stock_movement_fixture()
      assert Inventory.list_stock_movements() == [stock_movement]
    end

    test "get_stock_movement!/1 returns the stock_movement with given id" do
      stock_movement = stock_movement_fixture()
      assert Inventory.get_stock_movement!(stock_movement.id) == stock_movement
    end

    test "create_stock_movement/1 with valid data creates a stock_movement" do
      valid_attrs = %{reason: "some reason", type: "some type", quantity: 42}

      assert {:ok, %StockMovement{} = stock_movement} = Inventory.create_stock_movement(valid_attrs)
      assert stock_movement.reason == "some reason"
      assert stock_movement.type == "some type"
      assert stock_movement.quantity == 42
    end

    test "create_stock_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_stock_movement(@invalid_attrs)
    end

    test "update_stock_movement/2 with valid data updates the stock_movement" do
      stock_movement = stock_movement_fixture()
      update_attrs = %{reason: "some updated reason", type: "some updated type", quantity: 43}

      assert {:ok, %StockMovement{} = stock_movement} = Inventory.update_stock_movement(stock_movement, update_attrs)
      assert stock_movement.reason == "some updated reason"
      assert stock_movement.type == "some updated type"
      assert stock_movement.quantity == 43
    end

    test "update_stock_movement/2 with invalid data returns error changeset" do
      stock_movement = stock_movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_stock_movement(stock_movement, @invalid_attrs)
      assert stock_movement == Inventory.get_stock_movement!(stock_movement.id)
    end

    test "delete_stock_movement/1 deletes the stock_movement" do
      stock_movement = stock_movement_fixture()
      assert {:ok, %StockMovement{}} = Inventory.delete_stock_movement(stock_movement)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_stock_movement!(stock_movement.id) end
    end

    test "change_stock_movement/1 returns a stock_movement changeset" do
      stock_movement = stock_movement_fixture()
      assert %Ecto.Changeset{} = Inventory.change_stock_movement(stock_movement)
    end
  end
end
