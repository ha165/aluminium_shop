defmodule AluminiumShopWeb.SessionController do
  use AluminiumShopWeb, :controller

  alias AluminiumShop.Accounts

  def create(conn, params) do
    IO.inspect(params, label: "LOGIN PARAMS")

    identifier = params["identifier"]
    password = params["password"]

    if identifier && password do
      case Accounts.authenticate_user(identifier, password) do
        {:ok, user} ->
          conn
          |> renew_session()
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "Welcome back")
          |> redirect(to: "/dashboard")

        {:error, :invalid_credentials} ->
          conn
          |> put_flash(:error, "Invalid credentials")
          |> redirect(to: "/login")
      end
    else
      conn
      |> put_flash(:error, "Please provide both identifier and password")
      |> redirect(to: "/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/login")
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end
end
