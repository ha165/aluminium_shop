defmodule AluminiumShopWeb.LoginLive do
  use AluminiumShopWeb, :live_view

  alias AluminiumShop.Accounts

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto mt-20">
      <h1 class="text-2xl font-bold mb-4">Login</h1>

      <.form for={%{}} phx-submit="login">
        <input
          type="text"
          name="identifier"
          placeholder="Email or Phone"
          class="border p-2 w-full mb-3"
        />

        <input
          type="password"
          name="password"
          placeholder="Password"
          class="border p-2 w-full mb-3"
        />

        <button class="bg-blue-600 text-white px-4 py-2 rounded w-full">
          Login
        </button>
      </.form>

      <%= if @error do %>
        <p class="text-red-600 mt-3"><%= @error %></p>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, error: nil)}
  end

  def handle_event("login", %{"identifier" => id, "password" => pass}, socket) do
    case Accounts.authenticate_user(id, pass) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Welcome back")
         |> push_navigate(to: "/dashboard?user_id=#{user.id}")}

      {:error, :invalid_credentials} ->
        {:noreply, assign(socket, error: "Invalid credentials")}
    end
  end
end