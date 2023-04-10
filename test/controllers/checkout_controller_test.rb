require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get checkout_index_url
    assert_response :success
  end

  test "should get thankyou" do
    get checkout_thankyou_url
    assert_response :success
  end
end
