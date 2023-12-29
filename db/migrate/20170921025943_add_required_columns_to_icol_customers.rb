class AddRequiredColumnsToIcolCustomers < ActiveRecord::Migration
  def change
    add_column :icol_customers, :template_code, :integer, comment: 'the unique template code for a customer'
    IcolCustomer.where(:app_code => 'HUDABP').update_all(:template_code => 30)
    IcolCustomer.where(:app_code => 'HUDAVP').update_all(:template_code => 31)   
    change_column :icol_customers, :template_code, :integer, :null => false

    add_column :icol_customers, :use_proxy, :string, limit: 1, :null => false, :default => 'Y', comment: 'the identifier to tell if proxy has to be used for this customer'

    add_column :icol_customers, :setting6, :string, comment: 'the setting 6 for the customer'
    add_column :icol_customers, :setting7, :string, comment: 'the setting 7 for the customer'
    add_column :icol_customers, :setting8, :string, comment: 'the setting 8 for the customer'
    add_column :icol_customers, :setting9, :string, comment: 'the setting 9 for the customer'
    add_column :icol_customers, :setting10, :string, comment: 'the setting 10 for the customer'   

    remove_index :icol_customers, name: 'icol_customers_01'
    add_index :icol_customers, [:customer_code, :template_code, :approval_status], unique: true, name: 'icol_customers_01'
  end
end