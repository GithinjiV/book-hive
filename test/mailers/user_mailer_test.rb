require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome email" do
    user = User.new(name: "Taylor", email_address: "taylor@example.com")
    email = UserMailer.welcome(user)


    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ "taylor@example.com" ], email.to
    assert_equal [ "uncommontraders@gmail.com" ], email.from
    assert_equal "Welcome to Bookhive!", email.subject

    assert_match "Welcome", email.body.encoded
    assert_match "Taylor", email.body.encoded
  end
end
