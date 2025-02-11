module User::Role
  extend ActiveSupport::Concern

  included do
    enum :role, { patron: 0, librarian: 1 }
  end

  def can_administer?
    librarian?
  end
end
