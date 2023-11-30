class Comment < ApplicationRecord
    	belongs_to :ingredient
    	
    	validates :ingredient_id, presence: true
end
