defmodule AluminiumShopWeb.DashboardLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Accounts

def mount(_params, session, socket) do
  case session["user_id"] do
    nil ->
      {:halt,
       socket
       |> put_flash(:error, "Please login")
       |> redirect(to: "/login")}

    id ->
      user = Accounts.get_user!(id)
      {:ok, assign(socket, current_user: user)}
  end
end

  def render(assigns) do
    ~H"""
    <div class="p-8">
      <h1 class="text-3xl font-bold">Dashboard</h1>
      <%= if @current_user do %>
      <p class="mt-4">
        Welcome <%= @current_user.first_name %>
      </p>

      <p>
        Email: <%= @current_user.email %>
      </p>
      <% end %>
    </div>
    """
  end
end