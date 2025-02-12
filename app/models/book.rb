class Book < ApplicationRecord
  include Borrowable, CurrentCirculation

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
end
