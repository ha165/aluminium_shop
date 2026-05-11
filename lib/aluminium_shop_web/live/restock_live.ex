defmodule AluminiumShopWeb.RestockLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Catalog
  alias AluminiumShop.Inventory

  def mount(_, _, socket) do
    products = Catalog.list_products()

    {:ok,
     assign(socket,
       products: products,
       selected_product: nil
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-xl mx-auto p-6">
      <h1 class="text-2xl font-bold mb-6">
        Restock Inventory
      </h1>

      <.form for={%{}} phx-submit="restock">
        <div class="mb-4">
          <label class="block mb-2">
            Product
          </label>

          <select
            name="product_id"
            class="border rounded p-2 w-full"
          >
            <%= for product <- @products do %>
              <option value={product.id}>
                {product.name}
              </option>
            <% end %>
          </select>
        </div>

        <div class="mb-4">
          <label class="block mb-2">
            Quantity
          </label>

          <input
            type="number"
            name="quantity"
            min="1"
            class="border rounded p-2 w-full"
          />
        </div>

        <button
          type="submit"
          class="bg-blue-600 text-white px-4 py-2 rounded"
        >
          Restock
        </button>
      </.form>
    </div>
    """
  end

  def handle_event(
        "restock",
        %{
          "product_id" => product_id,
          "quantity" => quantity
        },
        socket
      ) do
    user_id = socket.assigns.current_user.id

    case Inventory.restock_product(
           product_id,
           String.to_integer(quantity),
           user_id
         ) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product restocked successfully")
         |> push_navigate(to: "/inventory")}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed: #{inspect(reason)}")}
    end
  end
end
