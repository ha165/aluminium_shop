defmodule AluminiumShopWeb.QuotationFormLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Sales
  alias AluminiumShop.Sales.Quotation

  def mount(_, _, socket) do
    changeset =
      Quotation.changeset(%Quotation{}, %{})

    {:ok,
     assign(socket,
       form: to_form(changeset)
     )}
  end

  def handle_event("save", %{"quotation" => params}, socket) do
    user_id = socket.assigns.current_user.id

    case Sales.create_quotation(params, user_id) do
      {:ok, quotation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quotation created")
         |> push_navigate(
           to: "/quotations/#{quotation.id}"
         )}

      {:error, changeset} ->
        {:noreply,
         assign(socket,
           form: to_form(changeset)
         )}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-xl mx-auto p-6">

      <h1 class="text-2xl font-bold mb-6">
        New Quotation
      </h1>

      <.form
        for={@form}
        phx-submit="save"
      >

        <div class="mb-4">
          <label>
            Customer ID
          </label>

          <input
            type="text"
            name="quotation[customer_id]"
            class="border p-2 w-full"
          />
        </div>

        <button
          type="submit"
          class="bg-blue-600 text-white px-4 py-2 rounded"
        >
          Create
        </button>

      </.form>
    </div>
    """
  end
end