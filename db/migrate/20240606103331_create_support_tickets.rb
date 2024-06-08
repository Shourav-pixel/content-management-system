class CreateSupportTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :support_tickets do |t|
      t.string :summary
      t.string :priority
      t.string :jira_key
      t.string :jira_url
      t.references :user, null: false, foreign_key: true
      t.references :storage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
