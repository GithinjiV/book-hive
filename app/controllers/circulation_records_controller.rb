class CirculationRecordsController < ApplicationController
  def check_out
    @book = Book.find(params[:book_id])
    @circulation_record = current_user.circulation_records.new(book: @book, due_date: 2.weeks.from_now)

    if @circulation_record.save
      redirect_to @book, notice: "Book checked out successfully!"
    else
      redirect_to @book, alert: "Unable to check out book."
    end
  end

  def check_in
    @circulation_record = CirculationRecord.find(params[:id])
    @circulation_record.update(returned_at: Time.current)
    redirect_to profile_path, notice: "Book checked in successfully!"
  end
end
