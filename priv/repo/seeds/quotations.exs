# priv/repo/seeds/quotations.exs

alias AluminiumShop.Repo

alias AluminiumShop.Sales.{
  Quotation,
  QuotationItem
}

alias AluminiumShop.Customers.Customer
alias AluminiumShop.Accounts.User
alias AluminiumShop.Catalog.Product

customers = Repo.all(Customer)
users = Repo.all(User)
products = Repo.all(Product)

Enum.each(1..500, fn _ ->
  quotation =
    Repo.insert!(
      %Quotation{}
      |> Quotation.changeset(%{
        customer_id: Enum.random(customers).id,
        created_by: Enum.random(users).id,
        status: Enum.random(["draft", "approved"]),
        total_amount: Decimal.new("0")
      })
    )

  items_count = Enum.random(1..5)

  Enum.each(1..items_count, fn _ ->
    product = Enum.random(products)
    quantity = Enum.random(1..10)
    unit_price = Decimal.new(Enum.random(100..10000))
    subtotal = Decimal.mult(unit_price, Decimal.new(quantity))

    Repo.insert!(
      %QuotationItem{}
      |> QuotationItem.changeset(%{
        quotation_id: quotation.id,
        product_id: product.id,
        quantity: quantity,
        unit_price: unit_price,
        subtotal: subtotal
      })
    )
  end)
end)