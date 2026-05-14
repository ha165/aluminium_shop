defmodule AluminiumShopWeb.InventoryLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Inventory

  def mount(_, _, socket) do
    inventories = Inventory.list_inventory()
  
  # Debug: Inspect the first inventory item
  case Enum.at(inventories, 0) do
    nil -> IO.puts("No inventory items found")
    first -> 
      IO.inspect(first, label: "First inventory item")
      IO.inspect(first.product, label: "Product association")
  end
    {:ok, assign(socket, inventories: Inventory.list_inventory())}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Inventory</h1>

      <%= for inventory <- @inventories do %>
        <div class="border p-4 mb-2 rounded">
          <h2 class="text-xl">
            {inventory.product.name}
          </h2>

          <p>
            Stock: {inventory.quantity}
          </p>

          <p>
            Location: {inventory.location}
          </p>
        </div>
      <% end %>
    </div>
    """
  end
end
