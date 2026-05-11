defmodule AluminiumShop.Repo.Migrations.CreateQuotations do
  use Ecto.Migration

  def change do
    create table(:quotations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :total_amount, :decimal
      add :customer_id, references(:customers, on_delete: :nothing)
      add :created_by, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:quotations, [:customer_id])
    create index(:quotations, [:created_by])
  end
end
