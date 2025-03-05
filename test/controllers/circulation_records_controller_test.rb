require "test_helper"

class CirculationRecordsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email_address: "user@example.com",
      password: "securepassword",
      password_confirmation: "securepassword",
      first_name: "Johnie",
      last_name: "Doe",
      username: "johniedoe"
   )

    @book = Book.create!(
      title: "Sample Book",
      author: "Author Name",
      isbn: "1234567890"
    )

    @circulation_record = CirculationRecord.create!(
      user: @user,
      book: @book,
      due_date: 2.weeks.from_now
    )

    sign_in_as(@user)  # Sign in before running tests
  end

  ### TESTS FOR CHECK OUT ###

  test "should check out book" do
    assert_difference("CirculationRecord.count", 1) do
      post check_out_book_url(@book)
    end

    assert_redirected_to book_url(@book)
    follow_redirect!
    assert_match "Book borrowed successfully!", response.body
  end


  test "should check in book" do
    circulation_record = CirculationRecord.create!(user: @user, book: @book, due_date: 2.weeks.from_now, returned_at: nil)

    patch check_in_circulation_record_url(circulation_record), as: :turbo_stream
    circulation_record.reload

    assert_not_nil circulation_record.returned_at
    assert_response :success
  end


  private

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "securepassword" }
    assert_response :redirect
    follow_redirect!
    assert_match "Welcome back #{user.first_name}!", response.body
  end

  def sign_out
    delete session_path
  end
end
