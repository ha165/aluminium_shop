defmodule AluminiumShop.Inventory.StockMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_movements" do
    field :quantity, :integer
    field :type, :string
    field :reason, :string
    field :product_id, :id
    field :created_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stock_movement, attrs) do
    stock_movement
    |> cast(attrs, [:quantity, :type, :reason])
    |> validate_required([:quantity, :type, :reason])
  end
end
