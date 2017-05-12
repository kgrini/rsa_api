class UsersController < ApplicationController
  before_action :validate_params

  def create
    user = User.new(user_params)

    result = if user.save
      {
        message: 'Successfully created a user',
        data: user
      }
    else
      {
        message: 'Failed to create a user',
        data: user.errors.messages
      }
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
        { message: 'Failed to create a user due to missing params', data: [] }
      )
      return
    end
  end
end
