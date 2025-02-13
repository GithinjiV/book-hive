class Book < ApplicationRecord
  include Borrowable, CurrentCirculation

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
end
