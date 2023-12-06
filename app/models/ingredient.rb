class Ingredient < ApplicationRecord
    belongs_to :genre
	belongs_to :user
	
	has_many :comments, dependent: :destroy
    
    validates :genre_id, :user_id, :name, :quantity, presence: true
    validates :quantity, numericality: { only_float: true }
    
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
