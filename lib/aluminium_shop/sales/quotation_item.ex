defmodule AluminiumShop.Sales.QuotationItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotation_items" do
    field :quantity, :integer
    field :unit_price, :decimal
    field :subtotal, :decimal

    belongs_to :quotation, AluminiumShop.Sales.Quotation
    belongs_to :product, AluminiumShop.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quotation_item, attrs) do
    quotation_item
    |> cast(attrs, [:quantity, :unit_price, :subtotal])
    |> validate_required([:quantity, :unit_price, :subtotal])
  end
end
