class Genre < ApplicationRecord
    has_many :ingredients, dependent: :destroy
    belongs_to :user
     
    validates :user_id, :name, presence: true
end
