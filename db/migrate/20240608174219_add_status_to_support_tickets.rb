class AddStatusToSupportTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :support_tickets, :status, :string
  end
end
