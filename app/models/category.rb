class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :books
    has_many :storages
end
