defmodule AluminiumShop.Repo.Migrations.CreateProductPrices do
  use Ecto.Migration

  def change do
    create table(:product_prices) do
      add :product_id, :uuid
      add :price, :decimal
      add :currency, :string
      add :effective_from, :utc_datetime
      
      timestamps(type: :utc_datetime)
    end

    create index(:product_prices, [:product_id])
  end
end
