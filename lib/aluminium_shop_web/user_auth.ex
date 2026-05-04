defmodule AluminiumShopWeb.UserAuth do
  import Phoenix.Component
  import Phoenix.LiveView
  alias AluminiumShop.Accounts
  alias AluminiumShop.Accounts.User
  alias AluminiumShop.Repo

  # -------- CONTROLLER (PLUG) --------

  def fetch_current_user(conn, _opts) do
    user =
      case Plug.Conn.get_session(conn, :user_id) do
        nil -> nil
        id -> Repo.get(User, id) |> Repo.preload(:role)
      end

    Plug.Conn.assign(conn, :current_user, user)
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "Please login first")
      |> Phoenix.Controller.redirect(to: "/login")
      |> Plug.Conn.halt()
    end
  end

  # -------- LIVEVIEW --------

  def on_mount(:default, _params, _session, socket) do
    {:cont, socket}
  end

  def on_mount(:require_authenticated_user, _params, session, socket) do
    case session["user_id"] do
      nil ->
        {:halt,
         socket
         |> put_flash(:error, "Please login")
         |> redirect(to: "/login")}

      id ->
        user = Repo.get(User, id) |> Repo.preload(:role)
        {:cont, assign(socket, :current_user, user)}
    end
  end

  # -------- Role Guards --------

  def on_mount(:require_admin, _params, session, socket) do
    case session["user_id"] do
      nil ->
        {:halt,
         socket
         |> put_flash(:error, "Please login")
         |> redirect(to: "/login")}

      id ->
        user = Repo.get(User, id) |> Repo.preload(:role)

        if user && user.role && user.role.name == "admin" do
          {:cont, assign(socket, :current_user, user)}
        else
          {:halt,
           socket
           |> put_flash(:error, "Access denied. Admin privileges required.")
           |> redirect(to: "/dashboard")}
        end
    end
  end
end
