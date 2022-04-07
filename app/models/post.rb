class Post < ApplicationRecord
  belongs_to :customer

  def self.search(search_word)
    Post.where(['category LIKE?', "#{search_word}"])
  end
end
