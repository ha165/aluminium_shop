defmodule AluminiumShopWeb.QuotationShowLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Sales
  alias AluminiumShop.Catalog

  def mount(%{"id" => id}, _, socket) do
    quotation = Sales.get_quotation!(id)
    products = Catalog.list_products()

    {:ok,
     assign(socket,
       quotation: quotation,
       products: products,
       selected_product_id: nil,
       quantity: 1,
       unit_price: nil
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="p-6 max-w-3xl mx-auto">
      <h1 class="text-2xl font-bold mb-4">
        Quotation #{@quotation.id}
      </h1>

      <p class="mb-4">
        Status: {@quotation.status}
      </p>

      <p class="mb-6">
        Total: {@quotation.total_amount}
      </p>
      
    <!-- ADD ITEM FORM -->
      <div class="border p-4 rounded mb-6">
        <h2 class="font-bold mb-3">
          Add Item
        </h2>

        <.form for={%{}} phx-change="select_product" phx-submit="add_item">
          
    <!-- Product -->
          <select name="product_id" class="border p-2 w-full mb-2">
            <option value="">Select product</option>

            <%= for product <- @products do %>
              <option value={product.id}>
                {product.name}
              </option>
            <% end %>
          </select>
          
    <!-- Quantity -->
          <input
            type="number"
            name="quantity"
            min="1"
            value="1"
            class="border p-2 w-full mb-2"
          />
          
    <!-- Unit Price -->
          <input
            type="text"
            name="unit_price"
            placeholder="Unit Price"
            value={@unit_price || ""}
            readonly
            class="border p-2 w-full mb-2"
          />

          <button class="bg-blue-600 text-white px-4 py-2 rounded">
            Add Item
          </button>
        </.form>
      </div>
      
    <!-- ITEMS LIST -->
      <div>
        <h2 class="font-bold mb-3">Items</h2>

        <%= for item <- @quotation.items do %>
          <div class="border p-3 mb-2 rounded">
            <p><strong>{item.product.name}</strong></p>
            <p>Qty: {item.quantity}</p>
            <p>Price: {item.unit_price}</p>
            <p>Subtotal: {item.subtotal}</p>
            <button
              phx-click="remove_item"
              phx-value-id={item.id}
              class="text-red-600"
            >
              Remove
            </button>
          </div>
        <% end %>
      </div>
      
    <!-- APPROVE -->
      <%= if @current_user.role.name == "admin" and @quotation.status == "draft" do %>
        <a
          href={"/quotations/#{@quotation.id}/approve"}
          class="bg-green-600 text-white px-4 py-2 rounded inline-block mt-4"
        >
          Approve Quotation
        </a>
      <% end %>
    </div>
    """
  end

  def handle_event("add_item", params, socket) do
    quotation = socket.assigns.quotation

    Sales.add_item(
      quotation.id,
      params["product_id"],
      String.to_integer(params["quantity"]),
      params["unit_price"]
    )

    updated = Sales.get_quotation!(quotation.id)

    {:noreply,
     assign(socket,
       quotation: updated,
       quantity: 1,
       unit_price: nil,
       selected_product_id: nil
     )}
  end

  def handle_event("select_product", %{"product_id" => ""}, socket) do
    {:noreply, assign(socket, unit_price: nil, selected_product_id: nil)}
  end

  def handle_event("select_product", %{"product_id" => id}, socket) do
    product = Enum.find(socket.assigns.products, &(&1.id == id))

    # You can later fetch real price from product_prices table
    # temporary fallback
    unit_price = "100"

    {:noreply,
     assign(socket,
       selected_product_id: id,
       unit_price: unit_price
     )}
  end
  def handle_event("remove_item", %{"id" => id}, socket) do
  Sales.delete_item(id)

  updated =
    Sales.get_quotation!(socket.assigns.quotation.id)

  {:noreply,
   assign(socket, quotation: updated)}
end
end
