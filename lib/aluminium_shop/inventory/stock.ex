defmodule AluminiumShop.Inventory.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventories" do
    field :quantity, :integer
    field :location, :string

    belongs_to :product, AluminiumShop.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:quantity, :location])
    |> validate_required([:quantity, :location])
  end
end
