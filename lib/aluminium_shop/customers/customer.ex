defmodule AluminiumShop.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :name, :string
    field :phone, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :phone, :email])
    |> validate_required([:name, :phone])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:phone)
  end
end
