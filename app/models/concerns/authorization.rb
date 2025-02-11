module Authorization
  private
  def ensure_can_administer
    head :not_found unless Current.user.can_administer?
  end

  def ensure_current_user
    head :not_found unless @user.current?
  end
end
