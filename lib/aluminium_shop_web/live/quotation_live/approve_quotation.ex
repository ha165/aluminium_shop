defmodule AluminiumShopWeb.ApproveQuotationLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Sales

  def mount(%{"id" => id}, _, socket) do
    case Sales.approve_quotation(id) do
      {:ok, _quotation} ->
        {:ok,
         socket
         |> put_flash(:info, "Quotation approved")
         |> push_navigate(to: "/quotations/#{id}")}

      {:error, reason} ->
        {:ok,
         socket
         |> put_flash(:error, "Failed: #{inspect(reason)}")
         |> push_navigate(to: "/quotations/#{id}")}
    end
  end
end
