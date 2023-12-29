class CreateTrnsctnStt < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      create_table :trnsctn_stt, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.integer :template_id, :null => false, :comment => "the template id"
        t.integer :compny_id, :null => false, :comment => "the company id"
        t.string :comapny_name, limit: 100, null: false, comment: 'the company name'
        t.string :trnsctn_mode, :limit => 3, :null => false, :comment => "the transaction mode"
        t.integer :trnsctn_nmbr, null: false, comment: "the unique transfer number" 
        t.datetime :crtd_date_time, :null => false, :comment => "the credit datetime"
        t.string :payment_status, :limit => 3, :null => false, :comment => "the Paymenyt status"
        t.string :template_data, limit: 1000, null: false, comment: 'the template data'
      end
      add_index :trnsctn_stt, :trnsctn_nmbr, :unique => true, :name => 'icol_notify_transactions_01' 
    end
  end

  def down
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      drop_table :trnsctn_stt
    end
  end
end
