class AddFaultColumnsToIcolNotifications < ActiveRecord::Migration
  def change
    add_column :icol_notifications, :fault_bitstream, :text, limit: 1000, comment: "the complete exception list/stack trace of an exception that occured in the ESB"
  end
end
