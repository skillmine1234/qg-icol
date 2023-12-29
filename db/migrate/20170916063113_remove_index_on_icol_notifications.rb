class RemoveIndexOnIcolNotifications < ActiveRecord::Migration
  def change
    remove_index :icol_notifications, name: 'icol_notifications_01'
  end
end
