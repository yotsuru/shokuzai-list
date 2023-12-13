class HomesController < ApplicationController
  before_action :authenticate_user!
  
  def top
    @ingredients = current_user.ingredients
  end
end
