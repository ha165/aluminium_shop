defmodule AluminiumShop.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset

   @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "categories" do
    field :name, :string

    belongs_to :parent, AluminiumShop.Catalog.Category,
      foreign_key: :parent_id,
      type: :binary_id

    has_many :subcategories, AluminiumShop.Catalog.Category,
      foreign_key: :parent_id

    has_many :products, AluminiumShop.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
  end
end
