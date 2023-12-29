class AddIndexToIcolNotifications < ActiveRecord::Migration
  def change
    add_index :icol_notifications, [:txn_number, :customer_code, :company_name], :unique => true, :name => "icol_notifications_01"    
  end
end
