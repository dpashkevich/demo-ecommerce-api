require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @new_customer_attributes = {
      name: "Alice",
      surname: "Johnson",
      email: "alice.johnson@example.com"
    }
  end

  test "should get index" do
    get customers_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "should create customer" do
    assert_difference("Customer.count") do
      post customers_url, params: { customer: @new_customer_attributes }, as: :json
    end

    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal @new_customer_attributes[:name], json_response["name"]
    assert_equal @new_customer_attributes[:surname], json_response["surname"]
    assert_equal @new_customer_attributes[:email], json_response["email"]
  end

  test "should not create customer with invalid email" do
    invalid_attributes = @new_customer_attributes.merge(email: "invalid-email")

    assert_no_difference("Customer.count") do
      post customers_url, params: { customer: invalid_attributes }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show customer" do
    get customer_url(@customer), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @customer.id, json_response["id"]
    assert_equal @customer.name, json_response["name"]
    assert_equal @customer.surname, json_response["surname"]
    assert_equal @customer.email, json_response["email"]
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { name: "Updated" } }, as: :json
    assert_response :success

    @customer.reload
    assert_equal "Updated", @customer.name
  end

  test "should destroy customer" do
    assert_difference("Customer.count", -1) do
      delete customer_url(@customer), as: :json
    end

    assert_response :no_content
  end

  test "should return not found for non-existent customer" do
    get customer_url(9999), as: :json
    assert_response :not_found
  end
end
