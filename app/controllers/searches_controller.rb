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
    # Time.currentで、JST(application.rbで指定したタイムゾーン)の時刻を取得
    # 文字列に変換後、Date.parseで日付に戻す
    @start_date = Date.parse(Time.current.to_s)
    #賞味期限検索の場合
    if params[:method] == "expiration"
      #今日から◯日後
      @end_date = @start_date + params[:date].to_i
      @ingredients = Ingredient.where(expiration_date: @start_date..@end_date).order(expiration_date: :asc)
    #購入日検索の場合
    elsif params[:method] == "purchase"
      #今日から◯日前
      @end_date = @start_date - params[:date].to_i
      @ingredients = Ingredient.where(purchase_date: @end_date..@start_date).order(purchase_date: :asc)
    else
      @ingredients = Ingredient.where("expiration_date < ?", @start_date).order(purchase_date: :asc)
    end
    @comment = Comment.new
  end
  
end

