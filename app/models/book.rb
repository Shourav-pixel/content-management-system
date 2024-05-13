class Book < ApplicationRecord
    include ImageUploader::Attachment(:image)
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
end
