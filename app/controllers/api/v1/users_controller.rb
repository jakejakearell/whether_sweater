class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if password_mismatch
      render json: {error: "Passwords must match",status: 404}, status: 404
    elsif user.save
      user.update(:api_key => SecureRandom.hex)
      render json:UserSerializer.new(user), status: 201
    else
      render json: {error: "#{user.errors.full_messages.first}",status: 404}, status: 404
    end
  end

  def user_params
    {email: params[:email].downcase, password: params[:password]}

  end

  def password_mismatch
    params[:password] != params[:password_confirmation]
  end
end
