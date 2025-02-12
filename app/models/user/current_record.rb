module User::CurrentRecord
  extend ActiveSupport::Concern

  included do
    def current_borrowings
      circulation_records.active.includes(:book)
    end

    def overdue_books
      current_borrowings.select(&:overdue?)
    end
  end
end
