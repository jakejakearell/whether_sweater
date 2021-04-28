class Api::V1::SessionsController < ApplicationController
  def create
    if !user
      render json: {error: "Request Bad",status: 404}, status: 404
    elsif user.authenticate(password)
      render json: UserSerializer.new(user), status: 200
    else
      render json: {error: "Request Bad",status: 404}, status: 404
    end
  end

  private

  def user
    User.find_by(email: email)
  end

  def email
    params[:email].downcase
  end

  def password
    params[:password]
  end
end
