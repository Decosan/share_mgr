require 'test_helper'

class CardPaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get card_payments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get card_payments_destroy_url
    assert_response :success
  end

end
