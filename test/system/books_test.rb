require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @new_book = Book.new(title: "Sample Book", author: "John Doe", isbn: "1234567890")
    @book = books(:one)
    @user = users(:one)
    sign_in_as(@user)  # Sign in before each test
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create book" do
    visit books_url
    click_on "Add New Book"

    fill_in "Author", with: @new_book.author
    fill_in "Isbn", with: @new_book.isbn
    fill_in "Title", with: @new_book.title
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back to Books"
  end

  test "should update Book" do
    visit book_url(@book)
    click_on "Edit Book", match: :first

    fill_in "Author", with: @book.author
    fill_in "Isbn", with: @book.isbn
    fill_in "Title", with: @book.title
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_on "Delete Book", match: :first
    assert_text "Are you sure you want to delete this book?"
    click_on "Confirm"
    assert_text "Book was successfully destroyed"
  end


  private

  def sign_in_as(user)
    visit new_session_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "password"
    click_on "Sign in"
    assert_text "Welcome back #{user.first_name}!"
  end
end
