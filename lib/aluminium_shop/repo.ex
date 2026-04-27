defmodule AluminiumShop.Repo do
  use Ecto.Repo,
    otp_app: :aluminium_shop,
    adapter: Ecto.Adapters.Postgres
end
