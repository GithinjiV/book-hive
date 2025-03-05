class UsersController < ApplicationController
  include Authorization
  before_action :set_user
  before_action :load_admin_resources, if: :user_can_administer
  def profile
    @current_borrowings = @user.current_borrowings
    @overdue_books = @user.overdue_books
    @borrowings = Current.user.circulation_records.includes(:book).order(created_at: :desc)
    @past_borrowings = @user.circulation_records.returned
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
    ensure_current_user
  end

  def load_admin_resources
    @books = Book.all
    @users = User.all
  end

  def user_can_administer
    @user.can_administer?
  end
end
