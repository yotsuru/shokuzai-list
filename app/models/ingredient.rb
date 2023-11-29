class Ingredient < ApplicationRecord
    belongs_to :genre
	belongs_to :user
    
    validates :genre_id, :user_id,:name, :quantity, presence: true
    validates :quantity, numericality: { only_float: true }
end
