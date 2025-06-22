require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get api_v1_orders_url, as: :json
    assert_response :success
  end

  test "should create order" do
    customer = customers(:one)
    shop_item = shop_items(:one)

    assert_difference("Order.count") do
      post api_v1_orders_url, params: {
        order: {
          customer_id: customer.id,
          order_items_attributes: [
            { shop_item_id: shop_item.id, quantity: 2 }
          ]
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should show order" do
    get api_v1_order_url(@order), as: :json
    assert_response :success
  end

  test "should update order" do
    patch api_v1_order_url(@order), params: { order: { customer_id: customers(:two).id } }, as: :json
    assert_response :success
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete api_v1_order_url(@order), as: :json
    end

    assert_response 204
  end

  test "should not create order without customer" do
    assert_no_difference("Order.count") do
      post api_v1_orders_url, params: { order: { order_items_attributes: [] } }, as: :json
    end

    assert_response 422
  end

  test "should return 404 for non-existent order" do
    get api_v1_order_url(999999), as: :json
    assert_response 404
  end
end
