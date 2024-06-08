class Book < ApplicationRecord
    include ImageUploader::Attachment(:image)
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
   
    has_many :taggings
    
    # has_many :taggings, foreign_key: 'books_id'
    has_many :tags, through: :taggings
    has_many :likes, as: :record
    has_many :comments, dependent: :destroy

    belongs_to :storage
    has_many :item_custom_vals, dependent: :destroy
    has_many :custom_fielders, through: :item_custom_vals
    accepts_nested_attributes_for :item_custom_vals, allow_destroy: true

   # scope :filter_by_title, -> (title) { where('title ILIKE ?', "%#{title}%") }

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

    #LIKING

  
    def liked_by?(user)
      likes.where(user: user).any?
    end
    def like(user)
      likes.where(user: user).first_or_create!
    end
    def unlike(user)
      likes.where(user: user).destroy_all
    end

end
