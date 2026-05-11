defmodule AluminiumShopWeb.QuotationIndexLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Sales

  def mount(_, _, socket) do
    quotations = Sales.list_quotations()

    {:ok,
     assign(socket,
       quotations: quotations
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="p-6">
      <div class="flex justify-between mb-6">
        <h1 class="text-2xl font-bold">
          Quotations
        </h1>

        <a
          href="/quotations/new"
          class="bg-blue-600 text-white px-4 py-2 rounded"
        >
          New Quotation
        </a>
      </div>

      <div class="space-y-4">
        <%= for quotation <- @quotations do %>
          <div class="border rounded p-4">

            <p>
              <strong>Status:</strong>
              <%= quotation.status %>
            </p>

            <p>
              <strong>Total:</strong>
              <%= quotation.total_amount %>
            </p>

            <a
              href={"/quotations/#{quotation.id}"}
              class="text-blue-600"
            >
              View
            </a>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end