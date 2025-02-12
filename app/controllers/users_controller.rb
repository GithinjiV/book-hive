class UsersController < ApplicationController
  def profile
    @user = Current.user
    @current_borrowings = @user.current_borrowings
    @overdue_books = @user.overdue_books
    @books = Book.all if @user.can_administer?
  end
end
