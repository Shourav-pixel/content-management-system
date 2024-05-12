class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.text :image_data
      t.string :author
      t.text :synopsis
      t.date :published_on

      t.timestamps
    end
  end
end
