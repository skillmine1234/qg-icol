class CreateIcolValidateSteps < ActiveRecord::Migration
  def change
    create_table :icol_validate_steps, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :step_name, limit: 100, null: false, comment: 'the english name of the step'
      t.string :status_code, limit: 100, null: false, comment: 'the status of this attempt of the step'
      t.string :app_code, limit: 50, comment: 'the app_code for the step'
      t.string :customer_code, limit: 15, comment: 'the customer_code for the step'
      
      t.datetime :req_timestamp, null: false, comment: 'the SYSDATE when the request was received'
      t.datetime :rep_timestamp, comment: 'the SYSDATE when the request was sent'
      
      t.datetime :up_req_timestamp, comment: 'the SYSDATE when the request built by the system was sent'
      t.string :up_host, limit: 100, comment: 'the up host for this request'
      t.string :up_req_uri, limit: 100, comment: 'the up request uri for this request'
      t.datetime :up_rep_timestamp, comment: 'the SYSDATE when the reply was received by the system'
      
      t.string :fault_code, limit: 50, comment: 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_subcode, limit: 50, comment: 'the error code that the third party will return'
      t.string :fault_reason, limit: 1000, comment: 'the english reason of the exception, if an exception occurred in the ESB'

      t.text :up_req_header, comment: 'the up request header for this request'
      t.text :up_rep_header, comment: 'the up reply header'
      t.text :up_req_bitstream, comment: 'the full request payload as received from the client'
      t.text :up_rep_bitstream, comment: 'the full request payload as received from the client'
      t.text :req_bitstream, null: false, comment: 'the full request payload as received from the client'
      t.text :rep_bitstream, comment: 'the full reply payload as sent to the client'
      t.text :fault_bitstream, comment: 'the complete exception list/stack trace of an exception that occured in the ESB'
    end
  end
end
