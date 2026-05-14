defmodule AluminiumShop.Repo.Migrations.CreateQuotationItems do
  use Ecto.Migration

  def change do
    create table(:quotation_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :unit_price, :decimal
      add :subtotal, :decimal
      add :quotation_id, references(:quotations, type: :binary_id, on_delete: :delete_all, null: false)
      add :product_id, references(:products, type: :binary_id, on_delete: :nothing, null: false)

      timestamps(type: :utc_datetime)
    end

    create index(:quotation_items, [:quotation_id])
    create index(:quotation_items, [:product_id])
  end
end
