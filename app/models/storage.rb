class Storage < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :user
  belongs_to :category
  has_many :custom_fielders, dependent: :destroy
  has_many :books, dependent: :destroy

  accepts_nested_attributes_for :custom_fielders, allow_destroy: true
end
