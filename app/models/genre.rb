class Genre < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  belongs_to :user
     
  validates :user_id, :name, presence: true
    
    # 検索方法分岐
  def self.looks(search, name)
    if search == "perfect_match"
      @genre = Genre.where("name LIKE?", "#{name}")
    elsif search == "forward_match"
      @genre = Genre.where("name LIKE?","#{name}%")
    elsif search == "backward_match"
      @genre = Genre.where("name LIKE?","%#{name}")
    elsif search == "partial_match"
      @genre = Genre.where("name LIKE?","%#{name}%")
    else
      @genre = Genre.all
    end
  end
end
