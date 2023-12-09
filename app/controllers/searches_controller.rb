class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "Genre"
      @genres = Genre.looks(params[:search], params[:name])
    else
      @ingredients = Ingredient.looks(params[:search], params[:name])
    end
    @comment = Comment.new
  end
  
  def search_by_date
    @start_date = Date.today
    if params[:method] == "expiration"
      @end_date = @start_date + params[:date].to_i
      @ingredients = Ingredient.where(expiration_date: @start_date..@end_date).order(expiration_date: :asc)
    else
      @end_date = @start_date - params[:date].to_i
      @ingredients = Ingredient.where(purchase_date: @end_date..@start_date).order(purchase_date: :asc)
    end
    @comment = Comment.new
  end
  
end

