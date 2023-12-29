class ChangeColumnTemplateDataInIcolNotifications < ActiveRecord::Migration
  def change
    remove_column :icol_notifications, :template_data, :string
    add_column :icol_notifications, :template_data, :text, default: 'a', null: false, comment: 'the template data'
  end
end
