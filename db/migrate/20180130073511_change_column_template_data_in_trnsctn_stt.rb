class ChangeColumnTemplateDataInTrnsctnStt < ActiveRecord::Migration  
  def change
    unless Rails.env == 'production'
      def self.connection
        Invxp.connection
      end
      remove_column :trnsctn_stt, :template_data
      add_column :trnsctn_stt, :template_data, :text, default: 'a', null: false, comment: 'the template data'
    end
  end
end
