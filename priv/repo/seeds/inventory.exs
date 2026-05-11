# priv/repo/seeds/inventory.exs

alias AluminiumShop.Repo
alias AluminiumShop.Inventory.Stock
alias AluminiumShop.Catalog.Product

products = Repo.all(Product)

Enum.each(products, fn product ->
  Repo.insert!(
    %Stock{}
    |> Stock.changeset(%{
      product_id: product.id,
      quantity: Enum.random(0..500),
      location: "Main Warehouse"
    })
  )
end)