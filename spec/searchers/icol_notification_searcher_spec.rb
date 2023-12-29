require 'spec_helper'

describe IcolNotificationSearcher do
  context "searcher" do
    it "should return icol_notification records" do
      icol_notification = Factory(:icol_notification, :app_code => "QW12345")
      IcolNotificationSearcher.new({:app_code => "QW12345"}).paginate.should == [icol_notification]
      IcolNotificationSearcher.new({:app_code => "QAQWSWQ"}).paginate.should == []

      icol_notification = Factory(:icol_notification, :customer_code => "Cust12345")
      IcolNotificationSearcher.new({:customer_code => "Cust12345"}).paginate.should == [icol_notification]
      IcolNotificationSearcher.new({:customer_code => "QAQWSWQ"}).paginate.should == []

      icol_notification = Factory(:icol_notification, :status_code => "NEW")
      IcolNotificationSearcher.new({:status_code => "NEW"}).paginate.should == [icol_notification]
      IcolNotificationSearcher.new({:status_code => "FAILED"}).paginate.should == []
      
      icol_notification = Factory(:icol_notification, :txn_number => "1238612")
      IcolNotificationSearcher.new({:txn_number => "1238612"}).paginate.should == [icol_notification]
      IcolNotificationSearcher.new({:txn_number => "00000000000"}).paginate.should == []
      IcolNotificationSearcher.new({:txn_number => "AAAAAAAAAAA"}).paginate.should == []
    end
  end
  
  context "txn code format" do 
    it "should allow valid format" do
      should allow_value('9876').for(:txn_number)
      should allow_value('9034').for(:txn_number)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:txn_number)
      should_not allow_value('CUST01/').for(:txn_number)
      should_not allow_value('CUST-01').for(:txn_number)
    end     
  end
end