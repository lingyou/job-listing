class WelcomeController < ApplicationController
  def index
    flash[:notice] = "welcome here"
  end
end
