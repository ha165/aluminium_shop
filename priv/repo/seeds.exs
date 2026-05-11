# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AluminiumShop.Repo.insert!(%AluminiumShop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# priv/repo/seeds.exs

Code.require_file("seeds/roles.exs", __DIR__)
Code.require_file("seeds/users.exs", __DIR__)
Code.require_file("seeds/categories.exs", __DIR__)
Code.require_file("seeds/products.exs", __DIR__)
Code.require_file("seeds/customers.exs", __DIR__)
Code.require_file("seeds/inventory.exs", __DIR__)
Code.require_file("seeds/quotations.exs", __DIR__)
