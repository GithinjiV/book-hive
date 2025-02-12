class CirculationRecord < ApplicationRecord
  include Circulation
  belongs_to :user
  belongs_to :book
end
