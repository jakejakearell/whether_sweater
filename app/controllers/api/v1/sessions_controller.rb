class Api::V1::SessionsController < ApplicationController
  def create
    # existing_user = User.find_by(email: email)
    # good = existing_user.authenticate(password)
    # if existing_user && good
    if User.find_by(email: email)
      user = User.find_by(email: email)
      if user.authenticate(password)
        render json: UserSerializer.new(user), status: 200
      else
        render json: {error: "Request Bad",status: 404}, status: 404
      end
    else
      render json: {error: "Request Bad",status: 404}, status: 404
    end
  end

  private

  def email
    params[:email].downcase
  end

  def password
    params[:password]
  end

  def user_params
    {email: params[:email].downcase, password: params[:password]}
  end
end
