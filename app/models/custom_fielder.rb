class CustomFielder < ApplicationRecord
  belongs_to :storage
  has_many :item_custom_vals, dependent: :destroy
  has_many :books, through: :item_custom_vals
end
