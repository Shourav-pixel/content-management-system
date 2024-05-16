class AddLikeCountToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :likes_count, :integer,default: 0
  end
end
