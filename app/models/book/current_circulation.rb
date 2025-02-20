module Book::CurrentCirculation
  extend ActiveSupport::Concern

  included do
    def current_circulation
      circulation_records.find_by(returned_at: nil)
    end

    def current_borrower
      current_circulation&.user
    end

    def overdue?
      current = current_circulation
      current && current.due_date < Date.current
    end
  end
end
