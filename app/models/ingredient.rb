class Ingredient < ApplicationRecord
    belongs_to :genre
	belongs_to :user
	
	has_many :comments, dependent: :destroy
    
    validates :genre_id, :user_id, :name, :quantity, presence: true
    validates :quantity, numericality: { only_float: true }
end
