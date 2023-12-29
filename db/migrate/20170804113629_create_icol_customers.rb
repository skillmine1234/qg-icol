class CreateIcolCustomers < ActiveRecord::Migration
  def change
    create_table :icol_customers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :customer_code, limit: 15, null: false, comment: 'the unique code for the customer'
      t.string :app_code, limit: 50, null: false, comment: 'the app_code for the customer'
      t.string :notify_url, limit: 100, comment: 'the notify_url for the customer'
      t.string :validate_url, limit: 100, comment: 'the validate_url for the customer'
      t.string :http_username, limit: 100, comment: 'the http_username for the customer'
      t.string :http_password, limit: 255, comment: 'the http_password for the customer'
      t.integer :max_retries_for_notify, default: 3, comment: 'the maximum no. of retries for notification for the customer'
      t.integer :retry_notify_in_mins, default: 3, comment: 'the interval in minutes for retrying notification for the customer'
      t.integer :settings_cnt, comment: 'the count of settings for the customer'
      t.string :setting1, comment: 'the setting 1 for the customer'
      t.string :setting2, comment: 'the setting 2 for the customer'
      t.string :setting3, comment: 'the setting 3 for the customer'
      t.string :setting4, comment: 'the setting 4 for the customer'
      t.string :setting5, comment: 'the setting 5 for the customer'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"
      t.string :is_enabled, limit: 1, :null => false, :default => 'Y', comment: 'the flag which indicates whether this customer is enabled or not'
 

      t.index([:customer_code, :approval_status], unique: true, name: 'icol_customers_01')
    end
  end
end
