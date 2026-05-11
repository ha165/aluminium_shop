defmodule AluminiumShop.Pricing do
  @moduledoc """
  The Pricing context.
  """

  import Ecto.Query, warn: false
  alias AluminiumShop.Repo

  alias AluminiumShop.Pricing.ProductPrice

  @doc """
  Returns the list of product_prices.

  ## Examples

      iex> list_product_prices()
      [%ProductPrice{}, ...]

  """
  def list_product_prices do
    Repo.all(ProductPrice)
  end

  @doc """
  Gets a single product_price.

  Raises `Ecto.NoResultsError` if the Product price does not exist.

  ## Examples

      iex> get_product_price!(123)
      %ProductPrice{}

      iex> get_product_price!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_price!(id), do: Repo.get!(ProductPrice, id)

  @doc """
  Creates a product_price.

  ## Examples

      iex> create_product_price(%{field: value})
      {:ok, %ProductPrice{}}

      iex> create_product_price(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_price(attrs) do
    %ProductPrice{}
    |> ProductPrice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_price.

  ## Examples

      iex> update_product_price(product_price, %{field: new_value})
      {:ok, %ProductPrice{}}

      iex> update_product_price(product_price, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_price(%ProductPrice{} = product_price, attrs) do
    product_price
    |> ProductPrice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_price.

  ## Examples

      iex> delete_product_price(product_price)
      {:ok, %ProductPrice{}}

      iex> delete_product_price(product_price)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_price(%ProductPrice{} = product_price) do
    Repo.delete(product_price)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_price changes.

  ## Examples

      iex> change_product_price(product_price)
      %Ecto.Changeset{data: %ProductPrice{}}

  """
  def change_product_price(%ProductPrice{} = product_price, attrs \\ %{}) do
    ProductPrice.changeset(product_price, attrs)
  end
end
