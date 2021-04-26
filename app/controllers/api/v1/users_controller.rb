class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.update(:api_key => SecureRandom.hex)
      render json:UserSerializer.new(user), status: 201
    end
  end


  private
  def user_params
    params.require(:body).permit(:email, :password)
  end
end
