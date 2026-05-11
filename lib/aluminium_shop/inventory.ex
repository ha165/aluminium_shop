defmodule AluminiumShop.Inventory do
  @moduledoc """
  The Inventory context manages product stock levels and stock movements.

  This context handles:
  - Tracking current stock levels for products
  - Recording all stock movements (IN/OUT)
  - Restocking products
  - Removing stock for sales/quotations
  - Maintaining audit trail of all inventory changes
  """

  import Ecto.Query, warn: false
  alias AluminiumShop.Repo
  alias AluminiumShop.Inventory.{Stock, StockMovement}

  # ============================================================================
  # Stock (Current Inventory) Functions
  # ============================================================================

  @doc """
  Returns the list of all inventory items with their products preloaded.

  ## Examples

      iex> list_inventory()
      [%Stock{product: %Product{}}, ...]
  """
  def list_inventory do
    Repo.all(Stock)
    |> Repo.preload(:product)
  end

  @doc """
  Returns the list of all inventory items (without preloading).

  ## Examples

      iex> list_stocks()
      [%Stock{}, ...]
  """
  def list_stocks do
    Repo.all(Stock)
  end

  @doc """
  Gets a single stock item by ID.

  Raises `Ecto.NoResultsError` if the Stock does not exist.

  ## Examples

      iex> get_stock!(123)
      %Stock{}

      iex> get_stock!(456)
      ** (Ecto.NoResultsError)
  """
  def get_stock!(id), do: Repo.get!(Stock, id)

  @doc """
  Gets a stock item by product ID.

  Returns `nil` if no stock record exists for the product.

  ## Examples

      iex> get_stock_by_product(1)
      %Stock{}

      iex> get_stock_by_product(999)
      nil
  """
  def get_stock_by_product(product_id) do
    Repo.get_by(Stock, product_id: product_id)
    |> Repo.preload(:product)
  end

  @doc """
  Creates a new stock item.

  ## Examples

      iex> create_stock(%{product_id: 1, quantity: 100, location: "Warehouse A"})
      {:ok, %Stock{}}

      iex> create_stock(%{product_id: nil})
      {:error, %Ecto.Changeset{}}
  """
  def create_stock(attrs) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock item.

  ## Examples

      iex> update_stock(stock, %{quantity: 150})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{quantity: -5})
      {:error, %Ecto.Changeset{}}
  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock item.

  ## Examples

      iex> delete_stock(stock)
      {:ok, %Stock{}}
  """
  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock changes.

  ## Examples

      iex> change_stock(stock)
      %Ecto.Changeset{data: %Stock{}}
  """
  def change_stock(%Stock{} = stock, attrs \\ %{}) do
    Stock.changeset(stock, attrs)
  end

  # ============================================================================
  # Stock Movement (Audit Log) Functions
  # ============================================================================

  @doc """
  Returns the list of all stock movements with their products preloaded.

  ## Examples

      iex> list_stock_movements()
      [%StockMovement{product: %Product{}}, ...]
  """
  def list_stock_movements do
    Repo.all(StockMovement)
    |> Repo.preload(:product)
  end

  @doc """
  Gets a single stock movement by ID.

  Raises `Ecto.NoResultsError` if the Stock movement does not exist.

  ## Examples

      iex> get_stock_movement!(123)
      %StockMovement{}

      iex> get_stock_movement!(456)
      ** (Ecto.NoResultsError)
  """
  def get_stock_movement!(id), do: Repo.get!(StockMovement, id)

  @doc """
  Returns all stock movements for a specific product.

  ## Examples

      iex> get_stock_movements_for_product(1)
      [%StockMovement{}, ...]
  """
  def get_stock_movements_for_product(product_id) do
    from(sm in StockMovement, where: sm.product_id == ^product_id)
    |> Repo.all()
    |> Repo.preload(:product)
  end

  @doc """
  Creates a stock movement record.

  ## Examples

      iex> create_stock_movement(%{product_id: 1, quantity: 50, type: "IN", reason: "Restock", created_by: 123})
      {:ok, %StockMovement{}}

      iex> create_stock_movement(%{product_id: nil})
      {:error, %Ecto.Changeset{}}
  """
  def create_stock_movement(attrs) do
    %StockMovement{}
    |> StockMovement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock movement record.

  ## Examples

      iex> update_stock_movement(stock_movement, %{reason: "Adjusted"})
      {:ok, %StockMovement{}}
  """
  def update_stock_movement(%StockMovement{} = stock_movement, attrs) do
    stock_movement
    |> StockMovement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock movement record.

  ## Examples

      iex> delete_stock_movement(stock_movement)
      {:ok, %StockMovement{}}
  """
  def delete_stock_movement(%StockMovement{} = stock_movement) do
    Repo.delete(stock_movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock movement changes.

  ## Examples

      iex> change_stock_movement(stock_movement)
      %Ecto.Changeset{data: %StockMovement{}}
  """
  def change_stock_movement(%StockMovement{} = stock_movement, attrs \\ %{}) do
    StockMovement.changeset(stock_movement, attrs)
  end

  # ============================================================================
  # Business Logic Functions
  # ============================================================================

  @doc """
  Restocks a product by adding quantity to inventory.

  If no inventory record exists for the product, it creates one with default location.

  This function:
  1. Finds or creates the inventory record
  2. Adds the quantity to existing stock
  3. Records the stock movement as "IN" with reason "Restock"

  ## Examples

      iex> restock_product(1, 50, 123)
      {:ok, %Stock{}}

      iex> restock_product(1, -5, 123)
      {:error, "Quantity must be positive"}
  """
  def restock_product(product_id, quantity, user_id) when quantity > 0 do
    Repo.transaction(fn ->
      # Find or create inventory record
      inventory = Repo.get_by(Stock, product_id: product_id)

      inventory =
        if inventory do
          inventory
        else
          %Stock{
            product_id: product_id,
            quantity: 0,
            location: "Default Location"
          }
          |> Repo.insert!()
        end

      # Update quantity
      new_quantity = inventory.quantity + quantity

      inventory
      |> Stock.changeset(%{quantity: new_quantity})
      |> Repo.update!()

      # Record movement
      %StockMovement{}
      |> StockMovement.changeset(%{
        product_id: product_id,
        quantity: quantity,
        type: "IN",
        reason: "Restock",
        created_by: user_id
      })
      |> Repo.insert!()
    end)
  end

  def restock_product(_product_id, quantity, _user_id) when quantity <= 0 do
    {:error, "Quantity must be positive"}
  end

  @doc """
  Removes stock from inventory for a product (e.g., when approving a quotation).

  This function:
  1. Finds the inventory record for the product
  2. Checks if sufficient stock is available
  3. Deducts the quantity from current stock
  4. Records the stock movement as "OUT" with reason "Quotation approved"

  Returns:
  - `{:ok, updated_inventory}` on success
  - `{:error, reason}` on failure

  ## Examples

      iex> remove_stock(1, 5, 123)
      {:ok, %Stock{quantity: 95}}

      iex> remove_stock(1, 200, 123)
      {:error, "Insufficient stock. Available: 95, Requested: 200"}

      iex> remove_stock(999, 5, 123)
      {:error, "Product not found in inventory"}
  """
  def remove_stock(product_id, quantity, user_id) when quantity > 0 do
    Repo.transaction(fn ->
      # Get inventory record with lock for race condition prevention
      inventory = Repo.get_by(Stock, product_id: product_id, lock: "FOR UPDATE")

      if is_nil(inventory) do
        Repo.rollback("Product not found in inventory")
      end

      # Check if enough stock
      if inventory.quantity < quantity do
        Repo.rollback(
          "Insufficient stock. Available: #{inventory.quantity}, Requested: #{quantity}"
        )
      end

      # Update inventory
      new_quantity = inventory.quantity - quantity

      updated_inventory =
        inventory
        |> Stock.changeset(%{quantity: new_quantity})
        |> Repo.update!()

      # Log the stock movement
      %StockMovement{}
      |> StockMovement.changeset(%{
        product_id: product_id,
        quantity: quantity,
        type: "OUT",
        reason: "Quotation approved",
        created_by: user_id
      })
      |> Repo.insert!()

      updated_inventory
    end)
  end

  # Handle zero or negative quantity
  def remove_stock(_product_id, quantity, _user_id) when quantity <= 0 do
    {:error, "Quantity must be positive"}
  end

  @doc """
  Gets the current stock quantity for a product.

  ## Examples

      iex> get_current_stock(1)
      100

      iex> get_current_stock(999)
      0
  """
  def get_current_stock(product_id) do
    case Repo.get_by(Stock, product_id: product_id) do
      nil -> 0
      stock -> stock.quantity
    end
  end

  @doc """
  Checks if a product has sufficient stock.

  Returns `true` if available stock >= requested quantity, `false` otherwise.

  ## Examples

      iex> has_sufficient_stock?(1, 50)
      true

      iex> has_sufficient_stock?(1, 200)
      false
  """
  def has_sufficient_stock?(product_id, requested_quantity) do
    current_stock = get_current_stock(product_id)
    current_stock >= requested_quantity
  end

  @doc """
  Moves stock between locations.

  ## Examples

      iex> move_stock(1, 25, "Warehouse A", "Store Front", 123)
      {:ok, %Stock{}}
  """
  def move_stock(product_id, quantity, from_location, to_location, user_id) when quantity > 0 do
    Repo.transaction(fn ->
      inventory = Repo.get_by(Stock, product_id: product_id)

      if is_nil(inventory) do
        Repo.rollback("Product not found in inventory")
      end

      if inventory.location != from_location do
        Repo.rollback("Product not found at source location")
      end

      if inventory.quantity < quantity do
        Repo.rollback("Insufficient stock at source location")
      end

      # Update location (simplified - in real app you might have location-specific tracking)
      updated_inventory =
        inventory
        |> Stock.changeset(%{location: to_location})
        |> Repo.update!()

      # Record movement with location change info
      %StockMovement{}
      |> StockMovement.changeset(%{
        product_id: product_id,
        quantity: quantity,
        type: "MOVE",
        reason: "Moved from #{from_location} to #{to_location}",
        created_by: user_id
      })
      |> Repo.insert!()

      updated_inventory
    end)
  end

  def move_stock(_product_id, quantity, _from_location, _to_location, _user_id)
      when quantity <= 0 do
    {:error, "Quantity must be positive"}
  end
end
