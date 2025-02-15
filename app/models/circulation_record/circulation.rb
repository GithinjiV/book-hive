module CirculationRecord::Circulation
  extend ActiveSupport::Concern

  included do
    validates :due_date, presence: true
    validate :due_date_in_future, on: :create

    scope :active, -> { where(returned_at: nil) }
    scope :overdue, -> { active.where("due_date < ?", Time.current) }
    scope :returned, -> { where.not(returned_at: nil) }

    def overdue?
      returned_at.nil? && due_date < Time.current
    end

    def return!
      update!(returned_at: Time.current)
    end

    def loan_duration
      end_date = returned_at || Time.current
      (end_date.to_date - created_at.to_date).to_i
    end

    def days_remaining
      return 0 if returned_at.present?
      (due_date - Date.current).to_i
    end

    private

    def due_date_in_future
      return unless due_date.present?
      if due_date <= Date.current
        errors.add(:due_date, "must be in the future")
      end
    end
  end
end
