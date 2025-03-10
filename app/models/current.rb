class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, to: :session, allow_nil: true

  # def user(=user)
  #   Time.zone = user.time_zone
  # end
end
