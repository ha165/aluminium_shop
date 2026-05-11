defmodule AluminiumShop.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
@foreign_key_type :binary_id

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
