defmodule AluminiumShop.Sales.QuotationItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotation_items" do
    field :quantity, :integer
    field :unit_price, :decimal
    field :subtotal, :decimal
    field :quotation_id, :id
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quotation_item, attrs) do
    quotation_item
    |> cast(attrs, [:quantity, :unit_price, :subtotal])
    |> validate_required([:quantity, :unit_price, :subtotal])
  end
end
