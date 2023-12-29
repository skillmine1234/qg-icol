class AddColumnsToIcolApps < ActiveRecord::Migration
  def change
    add_column :icol_apps, :expected_notify_input, :text, comment: 'the expected request payload as received from the client'    
    add_column :icol_apps, :expected_notify_output, :text, comment: 'the expected response payload as received from the client'    
    rename_column :icol_apps, :expected_input, :expected_validate_input
    rename_column :icol_apps, :expected_output, :expected_validate_output
  end
end
