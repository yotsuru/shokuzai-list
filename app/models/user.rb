class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :genres, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  
  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
  end
end
