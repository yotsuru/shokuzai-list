class Ingredient < ApplicationRecord
    belongs_to :genre
	belongs_to :user
	
	has_many :comments
    
    validates :genre_id, :user_id,:name, :quantity, presence: true
    validates :quantity, numericality: { only_float: true }
end
