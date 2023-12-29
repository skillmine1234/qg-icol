class ColumnRelatedChangesInIcolNotifications < ActiveRecord::Migration
  def change
    change_column :icol_notifications, :app_code, :string, limit: 50, :null => true
    change_column :icol_notifications, :company_id, :integer, :null => true
    change_column :icol_notifications, :template_id, :integer, :null => true
    add_column    :icol_notifications, :updated_at, :datetime, :null => true, comment: "the record is updated at"
  end
end
