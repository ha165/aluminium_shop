defmodule AluminiumShop.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :hashed_password, :string
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :role_id, references(:roles, type: :binary_id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:phone])  # You have this in your schema
    create index(:users, [:role_id])
  end
end