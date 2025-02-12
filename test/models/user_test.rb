require "test_helper"
require "ostruct"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email_address: "test@example.com",
      password: "securepassword",
      password_confirmation: "securepassword",
      first_name: "Johnie",
      last_name: "Doe",
      username: "johniedoe"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should normalize email by stripping spaces and downcasing" do
    @user.email_address = "  Test@Example.COM  "
    assert @user.save
    assert_equal "test@example.com", @user.reload.email_address
  end


  test "should require an email address" do
    @user.email_address = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "can't be blank"
  end

  test "should enforce unique email address" do
    @user.save!
    duplicate_user = @user.dup
    duplicate_user.email_address = @user.email_address.upcase
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email_address], "has already been taken"
  end



  test "should require a password with minimum length" do
    @user.password = @user.password_confirmation = "short"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "is too short (minimum is 10 characters)"
  end

  test "should require password confirmation" do
    @user.password_confirmation = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password_confirmation], "can't be blank"
  end

  test "should enforce password confirmation match" do
    @user.password_confirmation = "mismatchpassword"
    assert_not @user.valid?
    assert_includes @user.errors[:password_confirmation], "doesn't match Password"
  end

  test "should require first name" do
    @user.first_name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:first_name], "can't be blank"
  end

  test "should require last name" do
    @user.last_name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:last_name], "can't be blank"
  end

  test "should require username" do
    @user.username = nil
    assert_not @user.valid?
    assert_includes @user.errors[:username], "can't be blank"
  end

  test "should enforce unique username" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.username = @user.username
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:username], "has already been taken"
  end

  test "should return true for current? if user is Current.user" do
    session_mock = OpenStruct.new(user: @user)  # Create a mock session with the user
    Current.session = session_mock
    assert @user.current?
  end

  test "should return false for current? if user is not Current.user" do
    another_user = User.new
    session_mock = OpenStruct.new(user: another_user)  # Mock a session with a different user
    Current.session = session_mock
    assert_not @user.current?
  end
end
