class CreateItemCustomVals < ActiveRecord::Migration[7.1]
  def change
    create_table :item_custom_vals do |t|
      t.references :book, null: false, foreign_key: true
      t.references :custom_fielder, null: false, foreign_key: true
      t.text :field_value

      t.timestamps
    end
  end
end
