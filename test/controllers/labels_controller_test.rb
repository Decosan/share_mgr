require 'test_helper'

class LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get labels_create_url
    assert_response :success
  end

  test "should get destroy" do
    get labels_destroy_url
    assert_response :success
  end

end
