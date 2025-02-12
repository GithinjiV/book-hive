class User < ApplicationRecord
  include CurrentRecord, Role
  has_secure_password
  has_person_name
  has_many :sessions, dependent: :destroy
  has_many :circulation_records
  has_many :books, through: :circulation_records

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 10 }, if: -> { new_record? || changes[:password_digest] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  def current?
    self == Current.user
  end
end
