require 'test_helper'

class PersonnelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get personnels_new_url
    assert_response :success
  end

  test "should get create" do
    get personnels_create_url
    assert_response :success
  end

  test "should get edit" do
    get personnels_edit_url
    assert_response :success
  end

  test "should get update" do
    get personnels_update_url
    assert_response :success
  end

  test "should get show" do
    get personnels_show_url
    assert_response :success
  end

  test "should get destroy" do
    get personnels_destroy_url
    assert_response :success
  end

end
