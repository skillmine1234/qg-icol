class CreateIcolPendingNotifications < ActiveRecord::Migration
  def change
    create_table :icol_pending_notifications, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, null: false, comment: 'the uuid of the broker'
      t.string :icol_notification_id, null: false, comment: 'the id of the associated icol_notifications record'
      t.datetime :created_at, null: false, comment: 'the timestamp when the record was created'
    end
    add_index :icol_pending_notifications, [:broker_uuid,:icol_notification_id], unique: true, name: 'icol_p_notifications_01'
  end
end
