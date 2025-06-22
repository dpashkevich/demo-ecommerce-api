require "test_helper"

class Api::V1::ShopItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop_item = shop_items(:one)
  end

  test "should get index" do
    get api_v1_shop_items_url, as: :json
    assert_response :success
  end

  test "should create shop_item" do
    assert_difference("ShopItem.count") do
      post api_v1_shop_items_url, params: { shop_item: { title: "New Item", description: "New description", price: 99.99 } }, as: :json
    end

    assert_response 201
  end

  test "should show shop_item" do
    get api_v1_shop_item_url(@shop_item), as: :json
    assert_response :success
  end

  test "should update shop_item" do
    patch api_v1_shop_item_url(@shop_item), params: { shop_item: { title: "Updated Item" } }, as: :json
    assert_response :success
  end

  test "should destroy shop_item" do
    assert_difference("ShopItem.count", -1) do
      delete api_v1_shop_item_url(@shop_item), as: :json
    end

    assert_response 204
  end

  test "should not create shop_item without title" do
    assert_no_difference("ShopItem.count") do
      post api_v1_shop_items_url, params: { shop_item: { description: "Description only", price: 99.99 } }, as: :json
    end

    assert_response 422
  end

  test "should not create shop_item with negative price" do
    assert_no_difference("ShopItem.count") do
      post api_v1_shop_items_url, params: { shop_item: { title: "New Item", description: "Description", price: -10.0 } }, as: :json
    end

    assert_response 422
  end

  test "should return 404 for non-existent shop_item" do
    get api_v1_shop_item_url(999999), as: :json
    assert_response 404
  end
end
