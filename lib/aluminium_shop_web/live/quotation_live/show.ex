defmodule AluminiumShopWeb.QuotationShowLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Sales

  def mount(%{"id" => id}, _, socket) do
    quotation = Sales.get_quotation!(id)

    {:ok,
     assign(socket,
       quotation: quotation
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="p-6">

      <h1 class="text-2xl font-bold mb-4">
        Quotation
      </h1>

      <p>
        <strong>Status:</strong>
        <%= @quotation.status %>
      </p>

      <p>
        <strong>Total:</strong>
        <%= @quotation.total_amount %>
      </p>

      <h2 class="text-xl mt-6 mb-4">
        Items
      </h2>

      <%= for item <- @quotation.items do %>
        <div class="border p-4 mb-2 rounded">

          <p>
            Product:
            <%= item.product.name %>
          </p>

          <p>
            Quantity:
            <%= item.quantity %>
          </p>

          <p>
            Subtotal:
            <%= item.subtotal %>
          </p>

        </div>
      <% end %>

      <%= if @current_user.role.name == "admin" and @quotation.status == "draft" do %>

        <a
          href={"/quotations/#{@quotation.id}/approve"}
          class="bg-green-600 text-white px-4 py-2 rounded inline-block mt-4"
        >
          Approve
        </a>

      <% end %>
    </div>
    """
  end
end