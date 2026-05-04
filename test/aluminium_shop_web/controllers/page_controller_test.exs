defmodule AluminiumShopWeb.PageControllerTest do
  use AluminiumShopWeb.ConnCase

   test "GET / redirects to login", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Login"
  end
end
