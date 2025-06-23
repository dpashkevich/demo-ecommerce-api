require "test_helper"

class ShopItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop_item = shop_items(:one)
    @category = shop_item_categories(:one)
    @new_shop_item_attributes = {
      title: "Gaming Console",
      description: "Next-generation gaming console with 1TB storage",
      price: 499.99,
      shop_item_category_ids: [ @category.id ]
    }
  end

  test "should get index" do
    get shop_items_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "should create shop item" do
    assert_difference("ShopItem.count") do
      post shop_items_url, params: { shop_item: @new_shop_item_attributes }, as: :json
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal @new_shop_item_attributes[:title], json_response["title"]
    assert_equal @new_shop_item_attributes[:description], json_response["description"]
    assert_equal @new_shop_item_attributes[:price].to_s, json_response["price"]
  end

  test "should not create shop item with invalid price" do
    invalid_attributes = @new_shop_item_attributes.merge(price: -10)

    assert_no_difference("ShopItem.count") do
      post shop_items_url, params: { shop_item: invalid_attributes }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show shop item" do
    get shop_item_url(@shop_item), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @shop_item.id, json_response["id"]
    assert_equal @shop_item.title, json_response["title"]
    assert_equal @shop_item.description, json_response["description"]
    assert_equal @shop_item.price.to_s, json_response["price"]
  end

  test "should update shop item" do
    patch shop_item_url(@shop_item), params: { shop_item: { title: "Updated Item" } }, as: :json
    assert_response :success

    @shop_item.reload
    assert_equal "Updated Item", @shop_item.title
  end

  test "should destroy shop item" do
    # Create a new shop item to delete that's not used in orders
    shop_item = ShopItem.create!(title: "Temporary Item", price: 9.99)

    assert_difference("ShopItem.count", -1) do
      delete shop_item_url(shop_item), as: :json
    end

    assert_response :no_content
  end

  test "should return not found for non-existent shop item" do
    get shop_item_url(9999), as: :json
    assert_response :not_found
  end
end
