class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    result = if user.save
      { status: 'Successfully created a user', data: user }
    else
      { status: 'Failed to create a user', data: user.errors.messages }
    end
    render_response(result)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password)
  end
end
