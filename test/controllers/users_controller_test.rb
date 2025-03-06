require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @another_user = users(:two)
    sign_in_as @user
  end
  test "should get profile" do
    get users_profile_url(username: @user.username)
    assert_response :success
  end

  test "should only see own profile" do
    get users_profile_url(username: @another_user.username)
    assert :not_found
  end
end
