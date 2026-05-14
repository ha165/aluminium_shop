defmodule AluminiumShop.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
@foreign_key_type :binary_id

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
    |> cast(attrs, [:name, :sku, :description, :category_id])
    |> validate_required([:name, :sku, :description, :category_id])
    |> unique_constraint(:sku)
  end
end
