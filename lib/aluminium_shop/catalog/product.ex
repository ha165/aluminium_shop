defmodule AluminiumShop.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :sku, :string
    field :description, :string

    belongs_to :category, AluminiumShop.Catalog.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :sku, :description])
    |> validate_required([:name, :sku, :description])
    |> unique_constraint(:sku)
  end
end
