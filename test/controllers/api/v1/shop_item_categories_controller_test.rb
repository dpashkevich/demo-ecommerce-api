require "test_helper"

class Api::V1::ShopItemCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop_item_category = shop_item_categories(:one)
  end

  test "should get index" do
    get api_v1_shop_item_categories_url, as: :json
    assert_response :success
  end

  test "should create shop_item_category" do
    assert_difference("ShopItemCategory.count") do
      post api_v1_shop_item_categories_url, params: { shop_item_category: { title: "New Category", description: "New description" } }, as: :json
    end

    assert_response 201
  end

  test "should show shop_item_category" do
    get api_v1_shop_item_category_url(@shop_item_category), as: :json
    assert_response :success
  end

  test "should update shop_item_category" do
    patch api_v1_shop_item_category_url(@shop_item_category), params: { shop_item_category: { title: "Updated Category" } }, as: :json
    assert_response :success
  end

  test "should destroy shop_item_category" do
    assert_difference("ShopItemCategory.count", -1) do
      delete api_v1_shop_item_category_url(@shop_item_category), as: :json
    end

    assert_response 204
  end

  test "should not create shop_item_category without title" do
    assert_no_difference("ShopItemCategory.count") do
      post api_v1_shop_item_categories_url, params: { shop_item_category: { description: "Description only" } }, as: :json
    end

    assert_response 422
  end

  test "should return 404 for non-existent shop_item_category" do
    get api_v1_shop_item_category_url(999999), as: :json
    assert_response 404
  end
end
