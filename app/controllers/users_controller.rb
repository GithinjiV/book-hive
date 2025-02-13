class UsersController < ApplicationController
  before_action :set_user
  before_action :load_admin_resources, if: :user_can_administer
  def profile
    @current_borrowings = @user.current_borrowings
    @overdue_books = @user.overdue_books
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def load_admin_resources
    @books = Book.all
    @users = User.all
  end

  def user_can_administer
    @user.can_administer?
  end
end
