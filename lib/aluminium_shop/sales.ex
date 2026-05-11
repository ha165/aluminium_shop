defmodule AluminiumShop.Sales do
  @moduledoc """
  The Sales context manages quotations and their line items.

  This context handles:
  - Creating and managing quotations
  - Adding/removing items to quotations
  - Calculating totals
  - Approving quotations and updating inventory
  """

  import Ecto.Query, warn: false
  alias AluminiumShop.Repo
  alias AluminiumShop.Sales.{Quotation, QuotationItem}
  alias AluminiumShop.Catalog
  alias AluminiumShop.Inventory

  # ============================================================================
  # Quotation Functions
  # ============================================================================

  @doc """
  Returns the list of all quotations with customer and items preloaded.

  ## Examples

      iex> list_quotations()
      [%Quotation{}, ...]
  """
  def list_quotations do
    Repo.all(Quotation)
    |> Repo.preload(:customer, :items)
  end

  @doc """
  Gets a single quotation with its items and their products preloaded.

  Raises `Ecto.NoResultsError` if the Quotation does not exist.

  ## Examples

      iex> get_quotation!(123)
      %Quotation{}

      iex> get_quotation!(456)
      ** (Ecto.NoResultsError)
  """
  def get_quotation!(id) do
    Repo.get!(Quotation, id)
    |> Repo.preload(items: [:product])
  end

  @doc """
  Creates a new quotation.

  Automatically sets:
  - created_by: The user creating the quotation
  - status: "draft" by default
  - total_amount: "0.00" by default

  ## Examples

      iex> create_quotation(%{customer_id: 1, valid_until: ~D[2024-12-31]}, 123)
      {:ok, %Quotation{}}

      iex> create_quotation(%{customer_id: nil}, 123)
      {:error, %Ecto.Changeset{}}
  """
  def create_quotation(attrs, user_id) do
    attrs =
      attrs
      |> Map.put("created_by", user_id)
      |> Map.put("status", "draft")
      |> Map.put("total_amount", Decimal.new("0.00"))

    %Quotation{}
    |> Quotation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quotation.

  ## Examples

      iex> update_quotation(quotation, %{status: "sent"})
      {:ok, %Quotation{}}

      iex> update_quotation(quotation, %{status: nil})
      {:error, %Ecto.Changeset{}}
  """
  def update_quotation(%Quotation{} = quotation, attrs) do
    quotation
    |> Quotation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quotation.

  ## Examples

      iex> delete_quotation(quotation)
      {:ok, %Quotation{}}
  """
  def delete_quotation(%Quotation{} = quotation) do
    Repo.delete(quotation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quotation changes.

  ## Examples

      iex> change_quotation(quotation)
      %Ecto.Changeset{data: %Quotation{}}
  """
  def change_quotation(%Quotation{} = quotation, attrs \\ %{}) do
    Quotation.changeset(quotation, attrs)
  end

  @doc """
  Approves a quotation and deducts stock from inventory.

  This function:
  1. Loads the quotation with all items
  2. For each item, removes stock from inventory
  3. Updates the quotation status to "approved"

  The operation happens in a transaction - if any step fails, everything is rolled back.

  ## Examples

      iex> approve_quotation(123)
      {:ok, %Quotation{status: "approved"}}
  """
  def approve_quotation(quotation_id) do
    Repo.transaction(fn ->
      quotation =
        Repo.get!(Quotation, quotation_id)
        |> Repo.preload(:items)

      # Deduct stock for each item
      Enum.each(quotation.items, fn item ->
        Inventory.remove_stock(
          item.product_id,
          item.quantity,
          quotation.created_by
        )
      end)

      # Update quotation status
      quotation
      |> Quotation.changeset(%{status: "approved"})
      |> Repo.update!()
    end)
  end

  @doc """
  Recalculates and updates the total amount for a quotation.

  Sums up all item subtotals and updates the quotation's total_amount.

  ## Examples

      iex> recalculate_quotation_total(123)
      %Quotation{total_amount: Decimal.new("150.00")}
  """
  def recalculate_quotation_total(quotation_id) do
    quotation = Repo.get!(Quotation, quotation_id) |> Repo.preload(:items)

    total =
      quotation.items
      |> Enum.reduce(Decimal.new("0.00"), fn item, acc ->
        Decimal.add(acc, item.subtotal)
      end)

    quotation
    |> Quotation.changeset(%{total_amount: total})
    |> Repo.update!()
  end

  # ============================================================================
  # Quotation Item Functions
  # ============================================================================

  @doc """
  Returns the list of all quotation items.

  ## Examples

      iex> list_quotation_items()
      [%QuotationItem{}, ...]
  """
  def list_quotation_items do
    Repo.all(QuotationItem)
  end

  @doc """
  Gets a single quotation item.

  Raises `Ecto.NoResultsError` if the Quotation item does not exist.

  ## Examples

      iex> get_quotation_item!(123)
      %QuotationItem{}

      iex> get_quotation_item!(456)
      ** (Ecto.NoResultsError)
  """
  def get_quotation_item!(id), do: Repo.get!(QuotationItem, id)

  @doc """
  Creates a quotation item.

  ## Examples

      iex> create_quotation_item(%{quotation_id: 1, product_id: 1, quantity: 5})
      {:ok, %QuotationItem{}}
  """
  def create_quotation_item(attrs) do
    %QuotationItem{}
    |> QuotationItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quotation item.

  ## Examples

      iex> update_quotation_item(quotation_item, %{quantity: 10})
      {:ok, %QuotationItem{}}
  """
  def update_quotation_item(%QuotationItem{} = quotation_item, attrs) do
    quotation_item
    |> QuotationItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quotation item.

  ## Examples

      iex> delete_quotation_item(quotation_item)
      {:ok, %QuotationItem{}}
  """
  def delete_quotation_item(%QuotationItem{} = quotation_item) do
    Repo.delete(quotation_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quotation item changes.

  ## Examples

      iex> change_quotation_item(quotation_item)
      %Ecto.Changeset{data: %QuotationItem{}}
  """
  def change_quotation_item(%QuotationItem{} = quotation_item, attrs \\ %{}) do
    QuotationItem.changeset(quotation_item, attrs)
  end

  @doc """
  Adds an item to a quotation with automatic price lookup.

  This function:
  1. Gets the latest price for the product
  2. Calculates subtotal (quantity × unit price)
  3. Creates the quotation item
  4. Recalculates the quotation total

  ## Examples

      iex> add_item(123, 456, 5)
      {:ok, %QuotationItem{}}
  """
  def add_item(quotation_id, product_id, quantity, _unit_price \\ nil) do
    Repo.transaction(fn ->
      # Get latest price for product
      price = Catalog.get_latest_price(product_id)
      unit_price = price.price

      # Calculate subtotal
      subtotal = Decimal.mult(Decimal.new(quantity), unit_price)

      # Create item
      %QuotationItem{}
      |> QuotationItem.changeset(%{
        quotation_id: quotation_id,
        product_id: product_id,
        quantity: quantity,
        unit_price: unit_price,
        subtotal: subtotal
      })
      |> Repo.insert!()

      # Update total
      recalculate_quotation_total(quotation_id)
    end)
  end

  @doc """
  Adds an item to a quotation using provided price (no auto-lookup).

  This function:
  1. Calculates subtotal using the provided unit price
  2. Creates the quotation item
  3. Recalculates the quotation total

  ## Examples

      iex> add_item_to_quotation(123, %{product_id: 456, quantity: 5, unit_price: 10.99})
      {:ok, %QuotationItem{}}
  """
  def add_item_to_quotation(quotation_id, attrs) do
    Repo.transaction(fn ->
      # Calculate subtotal
      subtotal =
        Decimal.mult(
          Decimal.new(attrs["unit_price"]),
          Decimal.new(attrs["quantity"])
        )

      # Create item
      item_attrs =
        attrs
        |> Map.put("quotation_id", quotation_id)
        |> Map.put("subtotal", subtotal)

      item =
        %QuotationItem{}
        |> QuotationItem.changeset(item_attrs)
        |> Repo.insert!()

      # Update total
      recalculate_quotation_total(quotation_id)

      item
    end)
  end

  @doc """
  Deletes an item from a quotation and recalculates the total.

  ## Examples

      iex> delete_item(123)
      :ok
  """
  def delete_item(id) do
    item = Repo.get!(QuotationItem, id)
    quotation_id = item.quotation_id

    Repo.delete!(item)
    recalculate_quotation_total(quotation_id)

    :ok
  end
end
