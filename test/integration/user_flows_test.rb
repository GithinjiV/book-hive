require "test_helper"

class RegistrationsTest < ActionDispatch::IntegrationTest
  test "shows registration form" do
    get new_registration_path
    assert_response :success
    assert_select "form[action=?]", registrations_path do
      assert_select "input[name='user[email_address]']"
      assert_select "input[name='user[password]']"
      assert_select "input[name='user[password_confirmation]']"
      assert_select "input[name='user[first_name]']"
      assert_select "input[name='user[last_name]']"
      assert_select "input[name='user[username]']"
    end
  end

  test "creates new user with valid params" do
    assert_difference "User.count", 1 do
      post registrations_path, params: {
        user: {
          email_address: "janie@example.com",
          password: "password123",
          password_confirmation: "password123",
          first_name: "Janie",
          last_name: "Doe",
          username: "janiiedoe"
        }
      }
    end

    assert_redirected_to root_url
    assert_equal "Welcome back Janie!", flash[:notice]

    follow_redirect!
    assert_response :success
  end
end
