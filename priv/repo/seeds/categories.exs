# priv/repo/seeds/categories.exs

alias AluminiumShop.Repo
alias AluminiumShop.Catalog.Category

categories = [
  "Aluminium",
  "Rubber",
  "Glass",
  "Locks",
  "Handles",
  "Sliding Systems"
]

Enum.each(categories, fn name ->
  Repo.insert!(
    %Category{}
    |> Category.changeset(%{
      name: name
    })
  )
end)