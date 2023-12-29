require 'spec_helper'

describe IcolCustomerSearcher do

  context 'searcher' do
    it 'should return icol_customer records' do      
      icol_customer = Factory(:icol_customer, :app_code => 'app-123', :approval_status => 'A')
      IcolCustomerSearcher.new({:app_code => 'app-123'}).paginate.should == [icol_customer]
      IcolCustomerSearcher.new({:app_code => 'app.234'}).paginate.should == []
      
      icol_customer = Factory(:icol_customer, :customer_code => '2424', :approval_status => 'A')
      IcolCustomerSearcher.new({:customer_code => '2424'}).paginate.should == [icol_customer]
      IcolCustomerSearcher.new({:customer_code => '000000000'}).paginate.should == []
    end
  end
end