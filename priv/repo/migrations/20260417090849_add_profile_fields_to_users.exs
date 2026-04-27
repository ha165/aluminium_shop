defmodule AluminiumShop.Repo.Migrations.AddProfileFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
    end
    create unique_index(:users, [:phone])
  end
end
