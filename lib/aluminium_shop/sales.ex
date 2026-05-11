defmodule AluminiumShop.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias AluminiumShop.Repo

  alias AluminiumShop.Sales.Quotation

  @doc """
  Returns the list of quotations.

  ## Examples

      iex> list_quotations()
      [%Quotation{}, ...]

  """
  def list_quotations do
    Repo.all(Quotation)
  end

  @doc """
  Gets a single quotation.

  Raises `Ecto.NoResultsError` if the Quotation does not exist.

  ## Examples

      iex> get_quotation!(123)
      %Quotation{}

      iex> get_quotation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quotation!(id), do: Repo.get!(Quotation, id)

  @doc """
  Creates a quotation.

  ## Examples

      iex> create_quotation(%{field: value})
      {:ok, %Quotation{}}

      iex> create_quotation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quotation(attrs) do
    %Quotation{}
    |> Quotation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quotation.

  ## Examples

      iex> update_quotation(quotation, %{field: new_value})
      {:ok, %Quotation{}}

      iex> update_quotation(quotation, %{field: bad_value})
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

      iex> delete_quotation(quotation)
      {:error, %Ecto.Changeset{}}

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

  alias AluminiumShop.Sales.QuotationItem

  @doc """
  Returns the list of quotation_items.

  ## Examples

      iex> list_quotation_items()
      [%QuotationItem{}, ...]

  """
  def list_quotation_items do
    Repo.all(QuotationItem)
  end

  @doc """
  Gets a single quotation_item.

  Raises `Ecto.NoResultsError` if the Quotation item does not exist.

  ## Examples

      iex> get_quotation_item!(123)
      %QuotationItem{}

      iex> get_quotation_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quotation_item!(id), do: Repo.get!(QuotationItem, id)

  @doc """
  Creates a quotation_item.

  ## Examples

      iex> create_quotation_item(%{field: value})
      {:ok, %QuotationItem{}}

      iex> create_quotation_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quotation_item(attrs) do
    %QuotationItem{}
    |> QuotationItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quotation_item.

  ## Examples

      iex> update_quotation_item(quotation_item, %{field: new_value})
      {:ok, %QuotationItem{}}

      iex> update_quotation_item(quotation_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quotation_item(%QuotationItem{} = quotation_item, attrs) do
    quotation_item
    |> QuotationItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quotation_item.

  ## Examples

      iex> delete_quotation_item(quotation_item)
      {:ok, %QuotationItem{}}

      iex> delete_quotation_item(quotation_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quotation_item(%QuotationItem{} = quotation_item) do
    Repo.delete(quotation_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quotation_item changes.

  ## Examples

      iex> change_quotation_item(quotation_item)
      %Ecto.Changeset{data: %QuotationItem{}}

  """
  def change_quotation_item(%QuotationItem{} = quotation_item, attrs \\ %{}) do
    QuotationItem.changeset(quotation_item, attrs)
  end
end
