class AddStorageToBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :storage, null: false, foreign_key: true
  end
end
