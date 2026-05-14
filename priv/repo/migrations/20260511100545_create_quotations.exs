defmodule AluminiumShop.Repo.Migrations.CreateQuotations do
  use Ecto.Migration

  def change do
    create table(:quotations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :total_amount, :decimal
      add :customer_id, references(:customers, type: :binary_id, on_delete: :nothing, null: false)
      add :created_by, references(:users, type: :binary_id, on_delete: :nothing, null: false)

      timestamps(type: :utc_datetime)
    end

    create index(:quotations, [:customer_id])
    create index(:quotations, [:created_by])
  end
end
