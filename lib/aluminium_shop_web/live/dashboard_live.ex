defmodule AluminiumShopWeb.DashboardLive do
  use AluminiumShopWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-3xl p-8">Dashboard</h1>
    <p class="px-8">You are logged in.</p>
    """
  end
end