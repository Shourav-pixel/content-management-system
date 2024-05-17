class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_rich_text :body
end
