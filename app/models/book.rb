class Book < ApplicationRecord
  include Borrowable

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true
  validates :isbn, uniqueness: true
end
