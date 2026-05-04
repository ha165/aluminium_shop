defmodule AluminiumShop.CatalogTest do
  use AluminiumShop.DataCase
  
  alias AluminiumShop.Catalog
  alias AluminiumShop.Repo
  alias AluminiumShop.Catalog.Category
  describe "create_product/1" do
    setup do
      category = 
        %Category{}
        |> Category.changeset(%{name: "windows"})
        |> AluminiumShop.Repo.insert!()

      %{category: category}
    end

    test "creates valid product", %{category: category} do
      attrs = %{
        name: "Aluminium Window",
        description: "High quality aluminium window",
        sku: "12345",
        category_id: category.id
      }
      assert {:ok, product} = Catalog.create_product(attrs)
      assert product.name == "Aluminium Window"
    end
  end
end
