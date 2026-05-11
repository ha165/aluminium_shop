defmodule AluminiumShopWeb.ProductIndexLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Catalog
  alias AluminiumShop.Accounts

  def mount(_params, _session, socket) do
    {:ok, assign(socket, products: Catalog.list_products())}
  end

  def render(assigns) do
    ~H"""
    <div class="products-container">
      <%= for product <- @products do %>
        <div>
          <strong>{product.name}</strong> ({product.category.name})
        </div>
      <% end %>

      <%= if Accounts.is_admin?(@current_user) do %>
        <.link navigate={~p"/products/new"}>Add Product</.link>
      <% end %>
    </div>
    """
  end
end
