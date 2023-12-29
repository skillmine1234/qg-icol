require 'spec_helper'

describe IcolValidateStep do
  context 'icol_customer' do
    it 'should return the associated icol_customer record' do
      customer1 = Factory(:icol_customer, customer_code: 'EEE123', template_code: 123, approval_status: 'A')
      customer2 = Factory(:icol_customer, customer_code: 'EEE123', template_code: 12131, approval_status: 'A')
      icol_validate_step = Factory(:icol_validate_step, customer_code: 'EEE123', template_code: 123)
      icol_validate_step.icol_customer.should == customer1
    end
  end
end