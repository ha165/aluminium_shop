defmodule AluminiumShop.Sales.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :status, :string
    field :total_amount, :decimal
    field :customer_id, :id
    field :created_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:status, :total_amount])
    |> validate_required([:status, :total_amount])
  end
end
