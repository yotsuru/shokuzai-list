class Ingredient < ApplicationRecord
  belongs_to :genre, optional: true
	belongs_to :user
	
	has_many :comments, dependent: :destroy
    
  validates :user_id, :name, :quantity, presence: true
  validates :quantity, numericality: { only_float: true }
  
  # 並び替え機能
  scope :name_sort, -> {order(name: :asc)}
  # 登録の新しい順、古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  # 購入日の新しい順、古い順
  scope :purchase_date_latest, -> {order(Arel.sql("purchase_date DESC NULLS LAST"))}
  scope :purchase_date_old, -> {order(Arel.sql("purchase_date ASC NULLS LAST"))}
  # 賞味期限の早い順、遅い順
  scope :expiration_date_latest, -> {order(Arel.sql("expiration_date ASC NULLS LAST"))}
  scope :expiration_date_old, -> {order(Arel.sql("expiration_date DESC NULLS LAST"))}
  
  
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
