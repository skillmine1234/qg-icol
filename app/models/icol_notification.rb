class IcolNotification < ActiveRecord::Base
  lazy_load :fault_bitstream
  has_many :icol_notify_steps
  belongs_to :icol_customer, foreign_key: 'customer_code', primary_key: 'customer_code', class_name: 'IcolCustomer'
end