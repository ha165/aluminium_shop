defmodule AluminiumShopWeb.Router do
  use AluminiumShopWeb, :router

  # ---------------- PIPELINES ----------------

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AluminiumShopWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  defp fetch_current_user(conn, _opts) do
    AluminiumShopWeb.UserAuth.fetch_current_user(conn, [])
  end

  # ---------------- PUBLIC ----------------

  scope "/", AluminiumShopWeb do
    pipe_through :browser

    live_session :public,
      on_mount: [{AluminiumShopWeb.UserAuth, :default}] do
      live "/", LoginLive, :new
      live "/login", LoginLive, :new
    end

    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # ---------------- AUTHENTICATED ----------------

  scope "/", AluminiumShopWeb do
    pipe_through :browser

    live_session :authenticated,
      on_mount: [{AluminiumShopWeb.UserAuth, :require_authenticated_user}] do
      live "/dashboard", DashboardLive, :index
      live "/products/index", ProductIndexLive, :index
      live "/inventory", InventoryLive, :index
      live "/quotations", QuotationIndexLive, :index
      live "/quotations/new", QuotationFormLive, :new
      live "/quotations/:id", QuotationShowLive, :show
    end
  end

  # ---------------- ADMIN ----------------

  scope "/", AluminiumShopWeb do
    pipe_through :browser

    live_session :admin,
      on_mount: [
        {AluminiumShopWeb.UserAuth, :require_authenticated_user},
        {AluminiumShopWeb.UserAuth, :require_admin}
      ] do
      # live "/admin", AdminDashboardLive, :index
      # live "/users", UserManagementLive, :index
      live "/products/new", ProductFormLive, :new
      live "/inventory/restock", RestockLive, :new
      live "/quotations/:id/approve", ApproveQuotationLive, :approve
    end
  end
end
