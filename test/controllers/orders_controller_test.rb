require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @customer = customers(:one)
    @shop_item = shop_items(:one)

    @new_order_attributes = {
      customer_id: @customer.id,
      order_items_attributes: [
        {
          shop_item_id: @shop_item.id,
          quantity: 2
        }
      ]
    }
  end

  test "should get index" do
    get orders_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "should create order" do
    assert_difference("Order.count") do
      post orders_url, params: { order: @new_order_attributes }, as: :json
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal @customer.id, json_response["customer_id"]
  end

  test "should not create order without items" do
    invalid_attributes = { customer_id: @customer.id, order_items_attributes: [] }

    assert_no_difference("Order.count") do
      post orders_url, params: { order: invalid_attributes }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show order" do
    get order_url(@order), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @order.id, json_response["id"]
    assert_equal @order.customer_id, json_response["customer_id"]
    assert_not_empty json_response["order_items"]
  end

  test "should update order" do
    patch order_url(@order), params: {
      order: {
        order_items_attributes: [
          { id: @order.order_items.first.id, quantity: 3 }
        ]
      }
    }, as: :json

    assert_response :success

    @order.reload
    assert_equal 3, @order.order_items.reload.first.quantity
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order), as: :json
    end

    assert_response :no_content
  end

  test "should return not found for non-existent order" do
    get order_url(9999), as: :json
    assert_response :not_found
  end
end
