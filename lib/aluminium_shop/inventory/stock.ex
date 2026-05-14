defmodule AluminiumShop.Inventory.Stock do
  use Ecto.Schema
  import Ecto.Changeset

    @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "inventories" do
    field :quantity, :integer
    field :location, :string

    belongs_to :product, AluminiumShop.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:quantity, :location, :product_id])
    |> validate_required([:quantity, :location, :product_id])
  end
end
