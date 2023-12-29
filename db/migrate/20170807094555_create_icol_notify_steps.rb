class CreateIcolNotifySteps < ActiveRecord::Migration
  def change
    create_table :icol_notify_steps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :icol_notification_id, null: false, comment: 'the id of the associated icol_notification record'
      t.string :step_name, limit: 100, null: false, comment: 'the english name of the step'
      t.integer :attempt_no, null: false , comment: 'the attempt number of the request, failed requests can be retried'
      t.string :status_code, limit: 100, null: false, comment: 'the status of this attempt of the step'
      t.datetime :req_timestamp, null: false, comment: 'the SYSDATE when the request was sent to the service provider'
      t.string :remote_host, limit: 100, comment: 'the remiote host for this request'
      t.string :req_uri, limit: 100, comment: 'the uri for this request'
      t.datetime :rep_timestamp, comment: 'the SYSDATE when the reply was sent to the client'

      t.string :fault_code, limit: 50, comment: 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_subcode, limit: 50, comment: 'the error code that the third party will return'
      t.string :fault_reason, limit: 1000, comment: 'the english reason of the exception, if an exception occurred in the ESB'

      t.text :rep_header, comment: 'the header which were passed with the reply'
      t.text :req_header, comment: 'the header which were passed with the request'
      t.text :req_bitstream, null: false, comment: 'the full request payload as received from the client'
      t.text :rep_bitstream, comment: 'the full reply payload as sent to the client'
      t.text :fault_bitstream, comment: 'the complete exception list/stack trace of an exception that occured in the ESB'

      t.index([:icol_notification_id, :step_name, :attempt_no], unique: true, name: "icol_notify_steps_01")
    end
  end
end
