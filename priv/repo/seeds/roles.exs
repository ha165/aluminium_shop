# priv/repo/seeds/roles.exs

alias AluminiumShop.Repo
alias AluminiumShop.Accounts.Role

roles = [
  %{name: "admin"},
  %{name: "employee"}
]

Enum.each(roles, fn role ->
  Repo.insert!(
    %Role{}
    |> Role.changeset(role),
    on_conflict: :nothing
  )
end)