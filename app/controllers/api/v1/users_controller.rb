class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.save
    render json:UserSerializer.new(user), status: 201
  end


  private
  def user_params
    {email: params["item"]["email"],password: params["item"]["password"], api_key:SecureRandom.hex }
  end
end
