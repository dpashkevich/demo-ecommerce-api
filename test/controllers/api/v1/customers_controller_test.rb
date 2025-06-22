require "test_helper"

class Api::V1::CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get api_v1_customers_url, as: :json
    assert_response :success
  end

  test "should create customer" do
    assert_difference("Customer.count") do
      post api_v1_customers_url, params: { customer: { name: "Test", surname: "User", email: "test@example.com" } }, as: :json
    end

    assert_response 201
  end

  test "should show customer" do
    get api_v1_customer_url(@customer), as: :json
    assert_response :success
  end

  test "should update customer" do
    patch api_v1_customer_url(@customer), params: { customer: { name: "Updated" } }, as: :json
    assert_response :success
  end

  test "should destroy customer" do
    assert_difference("Customer.count", -1) do
      delete api_v1_customer_url(@customer), as: :json
    end

    assert_response 204
  end

  test "should not create customer with invalid email" do
    assert_no_difference("Customer.count") do
      post api_v1_customers_url, params: { customer: { name: "Test", surname: "User", email: "invalid-email" } }, as: :json
    end

    assert_response 422
  end

  test "should not create customer with duplicate email" do
    post api_v1_customers_url, params: { customer: { name: "Test", surname: "User", email: @customer.email } }, as: :json
    assert_response 422
  end

  test "should return 404 for non-existent customer" do
    get api_v1_customer_url(999999), as: :json
    assert_response 404
  end
end
