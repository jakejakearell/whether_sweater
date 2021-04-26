class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if password_mismatch
      render json: {error: "Passwords must match",status: 404}, status: 404
    elsif user.save
      user.update(:api_key => SecureRandom.hex)
      render json:UserSerializer.new(user), status: 201
    else
      render json: {error: "Some other error",status: 404}, status: 404
    end
  end


  private
  
  def user_params
    params.require(:body).permit(:email, :password)
  end

  def password_mismatch
    params[:body][:password] != params[:body][:password_confitmation]
  end
end
