# priv/repo/seeds/customers.exs

alias AluminiumShop.Repo
alias AluminiumShop.Customers.Customer

Enum.each(1..500, fn _ ->
  Repo.insert!(
    %Customer{}
    |> Customer.changeset(%{
      name: Faker.Company.name(),
      phone: Faker.Phone.EnUs.phone(),
      email: Faker.Internet.email()
    })
  )
end)