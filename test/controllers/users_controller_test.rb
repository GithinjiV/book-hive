require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as @user
  end
  test "should get profile" do
    get users_profile_url
    assert_response :success
  end
end
