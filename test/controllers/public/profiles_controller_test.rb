require "test_helper"

class Public::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_profiles_show_url
    assert_response :success
  end

  test "should get new" do
    get public_profiles_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_profiles_edit_url
    assert_response :success
  end

  test "should get index" do
    get public_profiles_index_url
    assert_response :success
  end
end
