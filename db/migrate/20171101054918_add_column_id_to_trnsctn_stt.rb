class AddColumnIdToTrnsctnStt < ActiveRecord::Migration
  def change
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      add_column :trnsctn_stt, :id, :integer
    end
  end
end
