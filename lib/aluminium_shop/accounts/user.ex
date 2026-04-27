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

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_user_by_phone(phone) do
    Repo.get_by(User, phone: phone)
  end

  def authenticate_user(email, password) do
  user = get_user_by_email(email)

  case user do
    nil ->
      {:error, :invalid_credentials}

    user ->
      if Bcrypt.verify_pass(password, user.hashed_password) do
        {:ok, user}
      else
        {:error, :invalid_credentials}
      end
  end
end
