defmodule AluminiumShopWeb.LoginLive do
  use AluminiumShopWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto mt-20">
      <h1 class="text-2xl font-bold mb-4">Login</h1>

      <form action="/login" method="post">
        <input type="hidden" name="_csrf_token" value={Phoenix.Controller.get_csrf_token()} />

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
      </form>
    </div>
    """
  end
end