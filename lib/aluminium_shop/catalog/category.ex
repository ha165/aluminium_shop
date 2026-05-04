defmodule AluminiumShop.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :parent_id, Ecto.UUID


    belongs_to :parent, __MODULE__, type: :binary_id
    has_many :subcategories, __MODULE__, foreign_key: :parent_id

    has_many :products, AluminiumShop.Catalog.Product

  timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name, :parent_id])
  end
end
