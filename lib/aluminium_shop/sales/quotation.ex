defmodule AluminiumShop.Sales.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :status, :string
    field :total_amount, :decimal

    belongs_to :customer, AluminiumShop.Customers.Customer
    belongs_to :creator, AluminiumShop.Accounts.User, foreign_key: :created_by

    has_many :items, AluminiumShop.Sales.QuotationItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:status, :total_amount])
    |> validate_required([:status, :total_amount])
  end
end
