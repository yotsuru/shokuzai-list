class Genre < ApplicationRecord
     has_many :ingredients
     
     validates :user_id, :name, presence: true
end
