class CreateIcolNotifications < ActiveRecord::Migration
  def change
    create_table :icol_notifications, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :app_code, limit: 50, null: false, comment: 'the app_code for the step'
      t.string :customer_code, limit: 15, comment: 'the customer_code for this request'
      t.string :status_code, limit: 100, null: false, comment: 'the status of this transaction'
      t.string :company_name, limit: 100, null: false, comment: 'the company name'
      t.integer :txn_number, null: false, comment: 'the UTR for this transaction'
      t.string :txn_mode, limit: 3, null: false, comment: 'the mode for this transaction'
      t.datetime :txn_date, null: false, comment: 'the transaction timestamp'
      t.string :payment_status, limit: 3, null: false, comment: 'the payment status'
      t.string :template_data, limit: 1000, null: false, comment: 'the template data'
      t.integer :template_id, null: false, comment: 'the template id'
      t.datetime :created_at, null: false, comment: 'the timestamp when this record was created'
      t.string :pending_approval, limit: 1, null: false, comment: 'the indicator which decides whether this record is pending to be approved'
      t.string :fault_code, limit: 50, comment: 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_subcode, limit: 50, comment: 'the error code that the third party will return'
      t.string :fault_reason, limit: 1000, comment: 'the english reason of the exception, if an exception occurred in the ESB'
      t.integer :attempt_no, comment: "the attempt no"
      t.integer :company_id, null: false, comment: "the company id"
      t.index([:company_name, :txn_number, :txn_mode, :payment_status], unique: true, name: "icol_notifications_01")
    end
  end
end
