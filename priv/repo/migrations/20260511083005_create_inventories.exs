defmodule AluminiumShop.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :location, :string
      add :product_id, references(:products, type: :binary_id, on_delete: :nothing, null: false)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:inventories, [:product_id])
  end
end
