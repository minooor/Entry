class Post < ApplicationRecord
  belongs_to :customer

  validates :game_on, presence: true
  validates :ground, presence: true
  validates :content, presence: true
  validates :category, presence: true

  def self.search(search_word)
    Post.where(['category LIKE?', "#{search_word}"])
  end
end
