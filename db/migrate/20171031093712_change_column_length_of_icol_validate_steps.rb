class ChangeColumnLengthOfIcolValidateSteps < ActiveRecord::Migration
  def change
    change_column :icol_validate_steps, :up_host, :string, :limit => 500
    change_column :icol_validate_steps, :up_req_uri, :string, :limit => 500
  end
end
