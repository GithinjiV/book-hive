class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  rate_limit to: 10,
    within: 3.minutes,
    only: :create,
    with: -> { redirect_to new_registration_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Welcome #{@user.first_name}!"
    else
      flash[:alert] =  "#{@user.errors.count} errors prohibited this user from being saved"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.expect(user: [ :email_address, :password, :password_confirmation, :first_name, :last_name, :username ])
  end
end
