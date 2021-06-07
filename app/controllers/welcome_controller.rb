class WelcomeController < ApplicationController
  def index
    render json: {endpoints: "https://github.com/jakejakearell/whether_sweater#readme"}
  end
end
