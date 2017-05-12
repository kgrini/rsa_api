class UsersController < ApplicationController
  before_action :validate_params

  def create
    user = User.new(user_params)

    result = if user.save && user.confirm
      { status: 'success', data: user }
    else
      { status: 'failed', data: user.errors.messages }
    end

    render_response(result)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password)
  end

  def validate_params
    if params[:user].blank?
      render_response(
        { status: 'failed', data: [] }
      )
      return
    end
  end
end
