class ChangeColumnLengthOfIcolNotifySteps < ActiveRecord::Migration
  def change
    change_column :icol_notify_steps, :remote_host, :string, :limit => 500
    change_column :icol_notify_steps, :req_uri, :string, :limit => 500
  end
end