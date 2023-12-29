require 'spec_helper'

describe IcolValidateStepSearcher do
  context "searcher" do
    it "should return icol_validate_step records" do
      icol_validate_step = Factory(:icol_validate_step, :app_code => "QW12345")
      IcolValidateStepSearcher.new({:app_code => "QW12345"}).paginate.should == [icol_validate_step]
      IcolValidateStepSearcher.new({:app_code => "QAQWSWQ"}).paginate.should == []
      
      icol_validate_step = Factory(:icol_validate_step, :customer_code => "Cust12345")
      IcolValidateStepSearcher.new({:customer_code => "Cust12345"}).paginate.should == [icol_validate_step]
      IcolValidateStepSearcher.new({:customer_code => "QAQWSWQ"}).paginate.should == []
      
      icol_validate_step = Factory(:icol_validate_step, :status_code => "NEW")
      IcolValidateStepSearcher.new({:status_code => "NEW"}).paginate.should == [icol_validate_step]
      IcolValidateStepSearcher.new({:status_code => "FAILED"}).paginate.should == []
      
      icol_validate_step = Factory(:icol_validate_step, :step_name => "Step12345")
      IcolValidateStepSearcher.new({:step_name => "Step12345"}).paginate.should == [icol_validate_step]
      IcolValidateStepSearcher.new({:step_name => "QAQWSWsdQ"}).paginate.should == []

      icol_validate_steps = [Factory(:icol_validate_step, req_timestamp: '2015-10-10')]
      icol_validate_steps << Factory(:icol_validate_step, req_timestamp: '2015-11-10')
      icol_validate_steps << Factory(:icol_validate_step, req_timestamp: '2016-02-01')
      IcolValidateStepSearcher.new({from_req_timestamp: '2015-10-10', to_req_timestamp: '2015-12-10'}).paginate.should == [icol_validate_steps[1], icol_validate_steps[0]]
      IcolValidateStepSearcher.new({from_req_timestamp: '2016-01-01', to_req_timestamp: '2016-12-12'}).paginate.should == [icol_validate_steps[2]]
      IcolValidateStepSearcher.new({from_req_timestamp: '2018-01-01', to_req_timestamp: '2018-12-12'}).paginate.should == []
      
      icol_validate_steps = [Factory(:icol_validate_step, rep_timestamp: '2015-10-10')]
      icol_validate_steps << Factory(:icol_validate_step, rep_timestamp: '2015-11-10')
      icol_validate_steps << Factory(:icol_validate_step, rep_timestamp: '2016-02-01')
      IcolValidateStepSearcher.new({from_rep_timestamp: '2015-10-10', to_rep_timestamp: '2015-12-10'}).paginate.should == [icol_validate_steps[1], icol_validate_steps[0]]
      IcolValidateStepSearcher.new({from_rep_timestamp: '2016-01-01', to_rep_timestamp: '2016-12-12'}).paginate.should == [icol_validate_steps[2]]
      IcolValidateStepSearcher.new({from_rep_timestamp: '2018-01-01', to_rep_timestamp: '2018-12-12'}).paginate.should == []
    end
  end
end