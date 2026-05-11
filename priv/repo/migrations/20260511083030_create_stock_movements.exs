defmodule AluminiumShop.Repo.Migrations.CreateStockMovements do
  use Ecto.Migration

  def change do
    create table(:stock_movements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :type, :string
      add :reason, :string
      add :product_id, references(:products, on_delete: :nothing)
      add :created_by, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:stock_movements, [:product_id])
    create index(:stock_movements, [:created_by])
  end
end
