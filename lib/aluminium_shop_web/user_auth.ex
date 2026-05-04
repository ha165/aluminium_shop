defmodule AluminiumShopWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias AluminiumShop.Accounts

  def fetch_current_user(conn, _opts) do
    user =
      case get_session(conn, :user_id) do
        nil -> nil
        id -> Accounts.get_user!(id)
      end

    assign(conn, :current_user, user)
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Please login first")
      |> redirect(to: "/login")
      |> halt()
    end
  end

  # -------- LiveView(on mount) --------
    def on_mount(:require_authenticated_user, _params, session, socket) do
    case session["user_id"] do
      nil ->
        {:halt,
         socket
         |> put_flash(:error, "Please login")
         |> redirect(to: "/login")}

      id ->
        user = Accounts.get_user!(id)
        {:cont, assign(socket, current_user: user)}
    end
  end
end