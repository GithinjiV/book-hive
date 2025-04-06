class CirculationRecordsController < ApplicationController
  def check_out
    @book = Book.friendly.find(params[:slug])
    @circulation_record = Current.user.circulation_records.new(book: @book, due_date: 2.weeks.from_now)

    if @circulation_record.save
      redirect_to @book, notice: "Book borrowed successfully!"
    else
      redirect_to @book, alert: "Unable to borrow book."
    end
  end

  def check_in
    @user = Current.user
    @current_borrowings = @user.current_borrowings
    @circulation_record = CirculationRecord.find(params[:id])
    @book = @circulation_record.book
    @circulation_record.return!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "borrowings",
            partial: "users/partials/profile",
            locals: { current_borrowings: @current_borrowings }
          )
        ]
      end
    end
  end
end
