defmodule AluminiumShop.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias AluminiumShop.Repo

  alias AluminiumShop.Inventory.Stock

  @doc """
  Returns the list of inventories.

  ## Examples

      iex> list_inventories()
      [%Stock{}, ...]

  """
  def list_inventories do
    Repo.all(Stock)
  end

  @doc """
  Gets a single stock.

  Raises `Ecto.NoResultsError` if the Stock does not exist.

  ## Examples

      iex> get_stock!(123)
      %Stock{}

      iex> get_stock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock!(id), do: Repo.get!(Stock, id)

  @doc """
  Creates a stock.

  ## Examples

      iex> create_stock(%{field: value})
      {:ok, %Stock{}}

      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock(attrs) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock.

  ## Examples

      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock.

  ## Examples

      iex> delete_stock(stock)
      {:ok, %Stock{}}

      iex> delete_stock(stock)
      {:error, %Ecto.Changeset{}}

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

  alias AluminiumShop.Inventory.StockMovement

  @doc """
  Returns the list of stock_movements.

  ## Examples

      iex> list_stock_movements()
      [%StockMovement{}, ...]

  """
  def list_stock_movements do
    Repo.all(StockMovement)
  end

  @doc """
  Gets a single stock_movement.

  Raises `Ecto.NoResultsError` if the Stock movement does not exist.

  ## Examples

      iex> get_stock_movement!(123)
      %StockMovement{}

      iex> get_stock_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_movement!(id), do: Repo.get!(StockMovement, id)

  @doc """
  Creates a stock_movement.

  ## Examples

      iex> create_stock_movement(%{field: value})
      {:ok, %StockMovement{}}

      iex> create_stock_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_movement(attrs) do
    %StockMovement{}
    |> StockMovement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock_movement.

  ## Examples

      iex> update_stock_movement(stock_movement, %{field: new_value})
      {:ok, %StockMovement{}}

      iex> update_stock_movement(stock_movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_movement(%StockMovement{} = stock_movement, attrs) do
    stock_movement
    |> StockMovement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock_movement.

  ## Examples

      iex> delete_stock_movement(stock_movement)
      {:ok, %StockMovement{}}

      iex> delete_stock_movement(stock_movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_movement(%StockMovement{} = stock_movement) do
    Repo.delete(stock_movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_movement changes.

  ## Examples

      iex> change_stock_movement(stock_movement)
      %Ecto.Changeset{data: %StockMovement{}}

  """
  def change_stock_movement(%StockMovement{} = stock_movement, attrs \\ %{}) do
    StockMovement.changeset(stock_movement, attrs)
  end
end
