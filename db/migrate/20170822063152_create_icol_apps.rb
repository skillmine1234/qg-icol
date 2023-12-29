class CreateIcolApps < ActiveRecord::Migration
  def change
    create_table :icol_apps, {sequence_start_value: '1 cache 20 order increment by 1'} do |t|
      t.string :app_code, null: false, limit: 50, comment: 'the code for the icol_app'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.text :expected_input,  comment: 'the expected request payload as received from the client'
      t.text :expected_output, comment: 'the expected reply payload as sent to the client'
      t.index([:app_code], unique: true, name: 'icol_apps_01') 
    end
  end
end
