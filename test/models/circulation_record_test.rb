require "test_helper"

class CirculationRecordTest < ActiveSupport::TestCase
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

    @circulation_record = CirculationRecord.new(
      user: @user,
      book: @book,
      due_date: Date.current + 7.days  # Valid due date in the future
    )
  end

  ### Validation Tests ###

  test "should be valid with valid attributes" do
    assert @circulation_record.valid?
  end

  test "should require a due_date" do
    @circulation_record.due_date = nil
    assert_not @circulation_record.valid?
    assert_includes @circulation_record.errors[:due_date], "can't be blank"
  end

  test "should require due_date to be in the future" do
    @circulation_record.due_date = Date.current
    assert_not @circulation_record.valid?
    assert_includes @circulation_record.errors[:due_date], "must be in the future"
  end

  test "should be invalid if due_date is in the past" do
    @circulation_record.due_date = Date.current - 1.day
    assert_not @circulation_record.valid?
    assert_includes @circulation_record.errors[:due_date], "must be in the future"
  end

  ### Scope Tests ###

  test "active scope should return records without returned_at" do
    @circulation_record.save!
    assert_includes CirculationRecord.active, @circulation_record
  end

  test "overdue scope should return records with past due_date and no returned_at" do
    @circulation_record.save!
    @circulation_record.update_column(:due_date, Date.current - 1.day)  # Bypass validation

    assert_includes CirculationRecord.overdue, @circulation_record
  end

  test "returned scope should return records with returned_at set" do
    @circulation_record.save!
    @circulation_record.return!
    assert_includes CirculationRecord.returned, @circulation_record
  end

  ### Instance Method Tests ###

  test "overdue? should return true if due_date is past and not returned" do
    @circulation_record.due_date = Date.current - 1.day
    assert @circulation_record.overdue?
  end

  test "overdue? should return false if returned_at is set" do
    @circulation_record.save!
    @circulation_record.return!
    assert_not @circulation_record.overdue?
  end

  test "return! should set returned_at to current time" do
    @circulation_record.save!
    freeze_time do
      @circulation_record.return!
      assert_not_nil @circulation_record.returned_at
      assert_equal Time.current.to_i, @circulation_record.returned_at.to_i
    end
  end

  test "loan_duration should calculate number of days between created_at and returned_at" do
    @circulation_record.save!
    @circulation_record.update!(created_at: Date.current - 5.days)
    @circulation_record.return!
    assert_equal 5, @circulation_record.loan_duration
  end

  test "loan_duration should use current time if not returned" do
    @circulation_record.save!
    @circulation_record.update!(created_at: Date.current - 5.days)
    assert_equal 5, @circulation_record.loan_duration
  end

  test "days_remaining should return days left until due_date" do
    @circulation_record.save!
    assert_equal 7, @circulation_record.days_remaining
  end

  test "days_remaining should return 0 if book is returned" do
    @circulation_record.save!
    @circulation_record.return!
    assert_equal 0, @circulation_record.days_remaining
  end
end
