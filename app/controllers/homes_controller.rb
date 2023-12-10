class HomesController < ApplicationController
  def top
    @ingredients = current_user.ingredients
  end
end
