require 'test_helper'

class EventLabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_labels_create_url
    assert_response :success
  end

  test "should get destroy" do
    get event_labels_destroy_url
    assert_response :success
  end

end
