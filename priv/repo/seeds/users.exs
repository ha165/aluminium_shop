# priv/repo/seeds/users.exs

alias AluminiumShop.Repo
alias AluminiumShop.Accounts
alias AluminiumShop.Accounts.{User, Role}

admin_role =
  Repo.get_by!(Role, name: "admin")

staff_role =
  Repo.get_by!(Role, name: "employee")

# Admin
{:ok, _admin} =
  Accounts.create_user(%{
    first_name: "System",
    last_name: "Admin",
    phone: "0700000000",
    email: "admin@shop.com",
    password: "password123",
    role_id: admin_role.id
  })

# 500 staff users
Enum.each(1..500, fn _ ->
  case Accounts.create_user(%{
         first_name: Faker.Person.first_name(),
         last_name: Faker.Person.last_name(),
         phone: Faker.Phone.EnUs.phone(),
         email: Faker.Internet.email(),
         password: "password123",
         role_id: staff_role.id
       }) do
    {:ok, _user} -> :ok
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Error creating user")
  end
end)
