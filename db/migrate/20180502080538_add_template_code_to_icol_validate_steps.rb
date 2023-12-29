class AddTemplateCodeToIcolValidateSteps < ActiveRecord::Migration
  def change
    add_column :icol_validate_steps, :template_code, :integer, comment: 'the unique template code for a customer'
  end
end
