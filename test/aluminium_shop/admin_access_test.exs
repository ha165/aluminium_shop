defmodule AluminiumShopWeb.AdminAccessTest do
  use AluminiumShopWeb.ConnCase
  import Phoenix.LiveViewTest
  
  alias AluminiumShop.Accounts
  alias AluminiumShop.Repo
  alias AluminiumShop.Accounts.Role
  alias AluminiumShop.Accounts.User

  setup do
    # Create admin role
    admin_role = %Role{name: "admin"}
    {:ok, admin_role} = Repo.insert(admin_role)
    
    # Create employee role
    employee_role = %Role{name: "employee"}
    {:ok, employee_role} = Repo.insert(employee_role)
    
    # Create admin user
    admin_user = %User{
      first_name: "Admin",
      last_name: "User",
      email: "admin@example.com",
      phone: "1234567890",
      role_id: admin_role.id,
      hashed_password: Bcrypt.hash_pwd_salt("password123")
    }
    {:ok, admin_user} = Repo.insert(admin_user)
    admin_user = Repo.preload(admin_user, :role)
    
    # Create regular employee user
    employee_user = %User{
      first_name: "Employee",
      last_name: "User",
      email: "employee@example.com",
      phone: "0987654321",
      role_id: employee_role.id,
      hashed_password: Bcrypt.hash_pwd_salt("password123")
    }
    {:ok, employee_user} = Repo.insert(employee_user)
    employee_user = Repo.preload(employee_user, :role)
    
    %{admin_user: admin_user, employee_user: employee_user}
  end

  describe "admin access to /products/new" do
    test "admin can access product form", %{admin_user: admin_user} do
      conn = build_conn()
      conn = log_in_user(conn, admin_user)
      
      {:ok, view, _html} = live(conn, "/products/new")
      
      assert has_element?(view, "h1", "Create New Product")
    end
    
    test "employee cannot access product form", %{employee_user: employee_user} do
      conn = build_conn()
      conn = log_in_user(conn, employee_user)
      
      {:error, {:redirect, %{to: "/dashboard"}}} = live(conn, "/products/new")
    end
    
    test "unauthenticated user cannot access product form" do
      conn = build_conn()
      {:error, {:redirect, %{to: "/login"}}} = live(conn, "/products/new")
    end
  end

  defp log_in_user(conn, user) do
    conn
    |> Plug.Test.init_test_session(%{})
    |> Plug.Conn.put_session(:user_id, user.id)
  end
end