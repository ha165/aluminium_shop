defmodule AluminiumShop.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  
    @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id 
  schema "roles" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
