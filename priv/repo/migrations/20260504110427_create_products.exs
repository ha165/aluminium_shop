defmodule AluminiumShop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :sku, :string, null: false
      add :description, :text
      add :category_id, references(:categories, type: :binary_id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end

    create unique_index(:products, [:sku])
    create index(:products, [:category_id])
  end
end
