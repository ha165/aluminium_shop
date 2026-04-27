defmodule AluminiumShopWeb.PageController do
  use AluminiumShopWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
