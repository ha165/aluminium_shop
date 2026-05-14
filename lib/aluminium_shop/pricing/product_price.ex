defmodule AluminiumShop.Pricing.ProductPrice do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
@foreign_key_type :binary_id

  schema "product_prices" do
    field :price, :decimal
    field :currency, :string
    field :effective_from, :utc_datetime

    belongs_to :product, AluminiumShop.Catalog.Product
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_price, attrs) do
    product_price
    |> cast(attrs, [:product_id, :price, :currency, :effective_from, :product_id])
    |> validate_required([:product_id, :price, :currency, :effective_from, :product_id])
    |> foreign_key_constraint(:product_id)
  end
end
