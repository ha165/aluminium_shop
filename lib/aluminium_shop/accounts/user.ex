defmodule AluminiumShop.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :email, :string

    field :password, :string, virtual: true
    field :hashed_password, :string

    belongs_to :role, AluminiumShop.Accounts.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone, :email, :role_id, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:first_name, :last_name, :phone, :email, :role_id])
    |> unique_constraint(:email)
    |>unique_constraint(:phone)
  end
end
