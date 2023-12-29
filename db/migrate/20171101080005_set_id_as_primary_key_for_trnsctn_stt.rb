class SetIdAsPrimaryKeyForTrnsctnStt < ActiveRecord::Migration
  def change
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      remove_column :trnsctn_stt, :id
      add_column :trnsctn_stt, :id, :primary_key
    end
  end
end
