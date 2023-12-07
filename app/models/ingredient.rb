class Ingredient < ApplicationRecord
  belongs_to :genre
	belongs_to :user
	
	has_many :comments, dependent: :destroy
    
  validates :genre_id, :user_id, :name, :quantity, presence: true
  validates :quantity, numericality: { only_float: true }
  
  # 並び替え機能
  # 登録の新しい順、古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  # 購入日の新しい順、古い順
  scope :purchase_date_latest, -> {order(purchase_date: :desc)}
  scope :purchase_date_old, -> {order(purchase_date: :asc)}
  # 賞味期限の近い順、遠い順
  scope :expiration_date_latest, -> {order(expiration_date: :desc)}
  scope :expiration_date_old, -> {order(expiration_date: :asc)}
  
  
  # 検索方法分岐
  def self.looks(search, name)
    if search == "perfect_match"
      @ingredient = Ingredient.where("name LIKE?", "#{name}")
    elsif search == "forward_match"
      @ingredient = Ingredient.where("name LIKE?","#{name}%")
    elsif search == "backward_match"
      @ingredient = Ingredient.where("name LIKE?","%#{name}")
    elsif search == "partial_match"
      @ingredient = Ingredient.where("name LIKE?","%#{name}%")
    else
      @ingredient = Ingredient.all
    end
  end
end
