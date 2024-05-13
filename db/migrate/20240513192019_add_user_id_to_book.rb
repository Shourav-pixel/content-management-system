class AddUserIdToBook < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :user, null: false,default: 0, foreign_key: true
  end
end
