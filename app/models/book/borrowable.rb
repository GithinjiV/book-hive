module Book::Borrowable
  extend ActiveSupport::Concern

  included do
    has_many :circulation_records
    has_many :borrowers, through: :circulation_records, source: :user
  end

  def borrowable?
    !currently_borrowed?
  end

  def currently_borrowed?
    circulation_records.where(returned_at: nil).exists?
  end
end
