class RemoveIdColumnFromTrnsctnStt < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      remove_column :trnsctn_stt, :id
    end
  end
end
