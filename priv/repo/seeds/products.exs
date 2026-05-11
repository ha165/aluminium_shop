# priv/repo/seeds/products.exs

alias AluminiumShop.Repo
alias AluminiumShop.Catalog.{Product, Category}
alias AluminiumShop.Pricing.ProductPrice

categories = Repo.all(Category)

Enum.each(1..500, fn i ->
  category = Enum.random(categories)

  product =
    Repo.insert!(
      %Product{}
      |> Product.changeset(%{
        name: "#{Faker.Commerce.product_name()} #{i}",
        sku: "SKU-#{1000 + i}",
        description: Faker.Lorem.sentence(),
        category_id: category.id
      })
    )

  Repo.insert!(
    %ProductPrice{}
    |> ProductPrice.changeset(%{
      product_id: product.id,
      price: Decimal.new(Enum.random(100..10000)),
      currency: "KES",
      effective_from: DateTime.utc_now()
    })
  )
end)