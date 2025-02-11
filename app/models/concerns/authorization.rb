module Authorization
  private
  def ensure_can_administer
    head :forbiddden unless Current.user.can_administer?
  end

  def ensure_current_user
    head :forbidden unless @user.current?
  end
end
