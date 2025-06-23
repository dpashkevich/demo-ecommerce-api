require "test_helper"

class ShopItemCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = shop_item_categories(:one)
    @new_category_attributes = {
      title: "Books",
      description: "Reading materials including fiction and non-fiction"
    }
  end

  test "should get index" do
    get shop_item_categories_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "should create shop item category" do
    assert_difference("ShopItemCategory.count") do
      post shop_item_categories_url, params: { shop_item_category: @new_category_attributes }, as: :json
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal @new_category_attributes[:title], json_response["title"]
    assert_equal @new_category_attributes[:description], json_response["description"]
  end

  test "should not create category without title" do
    invalid_attributes = @new_category_attributes.merge(title: "")

    assert_no_difference("ShopItemCategory.count") do
      post shop_item_categories_url, params: { shop_item_category: invalid_attributes }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show shop item category" do
    get shop_item_category_url(@category), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @category.id, json_response["id"]
    assert_equal @category.title, json_response["title"]
    assert_equal @category.description, json_response["description"]
  end

  test "should update shop item category" do
    patch shop_item_category_url(@category), params: { shop_item_category: { title: "Updated Category" } }, as: :json
    assert_response :success

    @category.reload
    assert_equal "Updated Category", @category.title
  end

  test "should destroy shop item category" do
    assert_difference("ShopItemCategory.count", -1) do
      delete shop_item_category_url(@category), as: :json
    end

    assert_response :no_content
  end

  test "should return not found for non-existent category" do
    get shop_item_category_url(9999), as: :json
    assert_response :not_found
  end
end
