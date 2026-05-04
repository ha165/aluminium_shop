defmodule AluminiumShop.CatalogTest do
  use AluminiumShop.DataCase
  
  alias AluminiumShop.Catalog
  alias AluminiumShop.Repo
  alias AluminiumShop.Catalog.Category

  describe "categories with parent" do
    setup do
      # Create parent category
      parent = 
        %Category{}
        |> Category.changeset(%{name: "Building Materials"})
        |> AluminiumShop.Repo.insert!()
      
      %{parent: parent}
    end

    test "creates child category with parent_id", %{parent: parent} do
      attrs = %{
        name: "Windows",
        parent_id: parent.id
      }
      
      # Create the child category
      child = 
        %Category{}
        |> Category.changeset(attrs)
        |> Repo.insert!()
      
      assert child.parent_id == parent.id
      assert child.name == "Windows"
    end

    test "create product with category", %{parent: parent} do
      attrs = %{
        name: "Aluminium window",
        description: "High quality aluminium window",
        sku: "ALWIN",
        category_id: parent.id
      }
      
      assert {:ok, product} = Catalog.create_product(attrs)
      assert product.name == "Aluminium window"
      assert product.sku == "ALWIN"
    end
  end

  
end