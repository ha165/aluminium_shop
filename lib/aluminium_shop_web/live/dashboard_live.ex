defmodule AluminiumShopWeb.DashboardLive do
  use AluminiumShopWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="p-8">
      <h1 class="text-3xl font-bold">Dashboard</h1>

      <p class="mt-4">
        Welcome <%= @current_user.first_name %>
      </p>

      <p>
        Email: <%= @current_user.email %>
      </p>
    </div>
    """
  end
end