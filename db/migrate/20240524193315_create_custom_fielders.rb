class CreateCustomFielders < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_fielders do |t|
      t.references :storage, null: false, foreign_key: true
      t.string :field_name
      t.string :field_type
      t.boolean :state

      t.timestamps
    end
  end
end
