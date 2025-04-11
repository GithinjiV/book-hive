# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.new(name: "Taylor", email_address: "taylor@example.com")
    UserMailer.welcome(user)
  end
end
