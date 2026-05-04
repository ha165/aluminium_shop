defmodule AluminiumShopWeb.DashboardLive do
  use AluminiumShopWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="p-8">
      <h1 class="text-3xl font-bold">Dashboard</h1>
      <%= if @current_user do %>
        <p class="mt-4">
          Welcome {@current_user.first_name}
        </p>

        <p>
          Email: {@current_user.email}
        </p>
      <% end %>
    </div>

    <.form for={:logout} method="delete" action={~p"/logout"}>
      <button type="submit">Log out</button>
    </.form>
    """
  end
end
