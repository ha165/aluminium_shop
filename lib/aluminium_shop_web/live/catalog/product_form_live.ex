defmodule AluminiumShopWeb.ProductFormLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Catalog
  alias AluminiumShop.Catalog.Product

  def mount(_params, _session, socket) do
    changeset = Product.changeset(%Product{}, %{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"product" => params}, socket) do
    case Catalog.create_product(params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created")
         |> push_navigate(to: "/products/new")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Create New Product</h1>
      
      <.form
        for={@changeset}
        id="product-form"
        phx-submit="save"
      >
        <div class="mb-4">
          <label class="block text-sm font-bold mb-2">Name</label>
          <input
            type="text"
            name="product[name]"
            value={get_field(@changeset, :name)}
            class="w-full p-2 border rounded"
          />
          <%= if error = get_error(@changeset, :name) do %>
            <span class="text-red-500 text-sm"><%= error %></span>
          <% end %>
        </div>

        <div class="mb-4">
          <label class="block text-sm font-bold mb-2">SKU</label>
          <input
            type="text"
            name="product[sku]"
            value={get_field(@changeset, :sku)}
            class="w-full p-2 border rounded"
          />
          <%= if error = get_error(@changeset, :sku) do %>
            <span class="text-red-500 text-sm"><%= error %></span>
          <% end %>
        </div>

        <div class="mb-4">
          <label class="block text-sm font-bold mb-2">Description</label>
          <textarea
            name="product[description]"
            class="w-full p-2 border rounded"
          ><%= get_field(@changeset, :description) %></textarea>
          <%= if error = get_error(@changeset, :description) do %>
            <span class="text-red-500 text-sm"><%= error %></span>
          <% end %>
        </div>

        <div class="mb-4">
          <label class="block text-sm font-bold mb-2">Category</label>
          <select name="product[category_id]" class="w-full p-2 border rounded">
            <option value="">Select a category</option>
            <%= for category <- Catalog.list_categories() do %>
              <option value={category.id} selected={get_field(@changeset, :category_id) == category.id}>
                <%= category.name %>
              </option>
            <% end %>
          </select>
          <%= if error = get_error(@changeset, :category_id) do %>
            <span class="text-red-500 text-sm"><%= error %></span>
          <% end %>
        </div>

        <div class="flex gap-2">
          <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
            Save Product
          </button>
          <.link navigate={~p"/products/new"} class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
            Cancel
          </.link>
        </div>
      </.form>
    </div>
    """
  end

  # Helper functions for the template
  defp get_field(changeset, field) do
    case Ecto.Changeset.fetch_field(changeset, field) do
      {:data, value} -> value
      _ -> nil
    end
  end

  defp get_error(changeset, field) do
    case keyword(changeset.errors, field) do
      [{^field, {message, _}}] -> message
      _ -> nil
    end
  end

  defp keyword(list, key) do
    Enum.filter(list, fn {k, _} -> k == key end)
  end
end