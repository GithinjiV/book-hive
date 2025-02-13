require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as @user
  end
  test "should get profile" do
    get users_profile_url(username: @user.username)
    assert_response :success
  end
end
