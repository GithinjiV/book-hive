require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Sample Book", author: "John Doe", isbn: "1234567890")
  end

  test "should be valid with valid attributes" do
    assert @book.valid?
  end

  test "should be invalid without a title" do
    @book.title = nil
    assert_not @book.valid?
    assert_includes @book.errors[:title], "can't be blank"
  end

  test "should be invalid without an author" do
    @book.author = nil
    assert_not @book.valid?
    assert_includes @book.errors[:author], "can't be blank"
  end

  test "should be invalid without an ISBN" do
    @book.isbn = nil
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], "can't be blank"
  end

  test "should enforce unique ISBNs" do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?
    assert_includes duplicate_book.errors[:isbn], "has already been taken"
  end
end
