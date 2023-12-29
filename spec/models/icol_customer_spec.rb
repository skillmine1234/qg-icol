require 'spec_helper'

describe IcolCustomer do

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "encrypt_password" do 
    it "should encrypt the http_password" do 
      icol_customer = Factory.build(:icol_customer, http_username: 'username', http_password: 'password')
      icol_customer.save.should be_true
      icol_customer.reload
      icol_customer.http_password.should == "password"
    end
    it "should encrypt the settings with type password" do 
      icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'value1', setting2_name: 'name2', setting2_type: 'password', setting2_value: 'password123')
      icol_customer.save.should be_true
      icol_customer.reload
      icol_customer.setting2_value.should == "password123"
    end
  end
  
  context "decrypt_password" do 
    it "should decrypt the http_password" do 
      icol_customer = Factory(:icol_customer, http_username: 'username', http_password: 'password')
      icol_customer.http_password.should == "password"
    end
    it "should decrypt the settings with type password" do 
      icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'value1', setting2_name: 'name2', setting2_type: 'password', setting2_value: 'password123')
      icol_customer.setting2_value.should == "password123"
    end
  end
  
  context "validation" do
    [:customer_code, :app_code, :is_enabled, :template_code, :use_proxy, :customer_name].each do |att|
      it { should validate_presence_of(att) }
    end
    
    context "validate_url, notify_url" do 
      it "notify_url " do 
        icol_customer = Factory.build(:icol_customer, validate_url: nil, notify_url: 'http://localhost:3002/icol_customers')
        icol_customer.save.should be_true 
      end

      it "validate_url " do 
        icol_customer = Factory.build(:icol_customer, validate_url: 'http://localhost:3002/icol_customers', notify_url: nil)
        icol_customer.save.should be_true 
      end
      
      it "should validate when validate_url and notify_url both are present" do 
        icol_customer = Factory.build(:icol_customer, validate_url: 'http://localhost:3002/icol_customers', notify_url: 'http://localhost:3002/icol_customers')
        icol_customer.save.should be_true 
      end
      
      it "validate_url and notify_url both are null" do
        icol_customer = Factory.build(:icol_customer, validate_url: nil, notify_url: nil)
        icol_customer.save.should be_false
        icol_customer.errors[:base].should == ["Either Notify URL or Validate URL must be present"]
      end
    end

    it "should validate presence of http_password if http_username is present" do
      icol_customer = Factory.build(:icol_customer, http_username: 'username', http_password: nil)
      icol_customer.save.should == false
      icol_customer.errors[:base].should == ["HTTP Password can't be blank if HTTP Username is present"]
    end
    
    it "should validate uniqueness of customer code" do
      icol_customer = Factory(:icol_customer, approval_status: 'A')
      should validate_uniqueness_of(:customer_code).scoped_to(:template_code, :approval_status)
    end    
    
    [:retry_notify_in_mins, :max_retries_for_notify, :template_code].each do |att|
      it { should validate_numericality_of(att).is_greater_than_or_equal_to(0) }
    end

    [:http_username, :notify_url, :validate_url].each do |att|
      it { should validate_length_of(att).is_at_most(100) }
    end
    
    it { should validate_length_of(:customer_code).is_at_most(15) }
    it { should validate_length_of(:customer_name).is_at_most(100) }
    it { should validate_length_of(:app_code).is_at_most(50) }

    context "format" do
      context "notify_url, validate_url" do 
        it "should accept value matching the format" do
          [:notify_url, :validate_url].each do |att|
            should allow_value('http://localhost:3000/icol_customers/1').for(att)
            should allow_value('https://google.com').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:notify_url, :validate_url].each do |att|
            should_not allow_value('localhost@name').for(att)
            should_not allow_value('user@123*^').for(att)
          end
        end
      end
      
      context "customer_code, app_code" do
        it "should accept value matching the format" do
          [:customer_code, :app_code].each do |att|
            should allow_value('APP123').for(att)
            should allow_value('APP-23456').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:customer_code, :app_code].each do |att|
            should_not allow_value('APP@123!').for(att)
            should_not allow_value('app~@123*^').for(att)
          end
        end
      end
      
      context "customer_name" do
        it "should accept value matching the format" do
          [:customer_name].each do |att|
            should allow_value('ABC Solutions').for(att)
            should allow_value('123Solutions').for(att)
            should allow_value('123-Solutions').for(att)
            should allow_value('123-Solutions Pvt. LTD').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:customer_name].each do |att|
            should_not allow_value('APP@123!').for(att)
            should_not allow_value('app~@123*^').for(att)
          end
        end
      end
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      icol_customer1 = Factory(:icol_customer, :approval_status => 'A') 
      icol_customer2 = Factory(:icol_customer)
      IcolCustomer.all.should == [icol_customer1]
      icol_customer2.approval_status = 'A'
      icol_customer2.save
      IcolCustomer.all.should == [icol_customer1,icol_customer2]
    end
  end    

  context "unapproved_records" do 
    it "oncreate: should create unapproved_record if the approval_status is 'U'" do
      icol_customer = Factory(:icol_customer)
      icol_customer.reload
      icol_customer.unapproved_record_entry.should_not be_nil
    end

    it "oncreate: should not create unapproved_record if the approval_status is 'A'" do
      icol_customer = Factory(:icol_customer, :approval_status => 'A')
      icol_customer.unapproved_record_entry.should be_nil
    end

    it "onupdate: should not remove unapproved_record if approval_status did not change from U to A" do
      icol_customer = Factory(:icol_customer)
      icol_customer.reload
      icol_customer.unapproved_record_entry.should_not be_nil
      record = icol_customer.unapproved_record_entry
      # we are editing the U record, before it is approved
      icol_customer.app_code = 'Foo123'
      icol_customer.save
      icol_customer.reload
      icol_customer.unapproved_record_entry.should == record
    end

    it "onupdate: should remove unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      icol_customer = Factory(:icol_customer)
      icol_customer.reload
      icol_customer.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      icol_customer.approval_status = 'A'
      icol_customer.save
      icol_customer.reload
      icol_customer.unapproved_record_entry.should be_nil
    end

    it "ondestroy: should remove unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      icol_customer = Factory(:icol_customer)
      icol_customer.reload
      icol_customer.unapproved_record_entry.should_not be_nil
      record = icol_customer.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      icol_customer.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end
  
  context "set_settings_cnt" do
    it "should set counts of settings_count 1" do
      icol_customer = Factory(:icol_customer, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1')
      icol_customer.settings_cnt.should == 1
    end
    
    it "should set counts of settings_count 2" do
      icol_customer = Factory(:icol_customer, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' , setting2_name: 'set1', setting2_type: 'number', setting2_value: '1')
      icol_customer.settings_cnt.should == 2
    end
    
    it "should set counts of settings_count 3" do
      icol_customer = Factory(:icol_customer, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
       setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
       setting3_name: 'set1', setting3_type: 'number', setting3_value: '1')
      icol_customer.settings_cnt.should == 3
    end
    
    it "should set counts of settings_count 4" do
      icol_customer = Factory(:icol_customer, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
       setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
       setting3_name: 'set1', setting3_type: 'number', setting3_value: '1',
       setting4_name: 'set1', setting4_type: 'number', setting4_value: '1')
      icol_customer.settings_cnt.should == 4
    end
    
    it "should set counts of settings_count 4" do
      icol_customer = Factory(:icol_customer, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
       setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
       setting3_name: 'set1', setting3_type: 'number', setting3_value: '1',
       setting4_name: 'set1', setting4_type: 'number', setting4_value: '1',
       setting5_name: 'set1', setting5_type: 'number', setting5_value: '1')
      icol_customer.settings_cnt.should == 5
    end
  end
  
  it "should validate presence of setting names" do
    icol_customer = Factory.build(:icol_customer, setting1_name: nil, setting2_name: 'setting2')
    icol_customer.save.should == false
    icol_customer.errors_on(:setting1_name).should == ["can't be blank when Setting2 name is present"]
    
    icol_customer = Factory.build(:icol_customer, setting2_name: nil, setting3_name: 'setting3')
    icol_customer.save.should == false
    icol_customer.errors_on(:setting2_name).should == ["can't be blank when Setting3 name is present"]
    
    icol_customer = Factory.build(:icol_customer, setting3_name: nil, setting4_name: 'setting4')
    icol_customer.save.should == false
    icol_customer.errors_on(:setting3_name).should == ["can't be blank when Setting4 name is present"]
    
    icol_customer = Factory.build(:icol_customer, setting4_name: nil, setting5_name: 'setting5')
    icol_customer.save.should == false
    icol_customer.errors_on(:setting4_name).should == ["can't be blank when Setting5 name is present"]
  end

  it "should validate the setting values" do
    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'text', setting1_value: nil)
    icol_customer.save.should == false
    icol_customer.errors_on('name1').should == ["can't be blank"]

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'text')
    icol_customer.save.should == true
    icol_customer.errors_on('name1').should == []

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'number', setting1_value: 'TEXT')
    icol_customer.save.should == false
    icol_customer.errors_on('name1').should == ["should include only digits"]

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'number', setting1_value: '1234')
    icol_customer.save.should == true
    icol_customer.errors_on('name1').should == []

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'yterqweytweuyqtweyqteyqtwerqwyertqweuryqwieuryqwerehquqwkjhequeuqeyuqjwhegruqywerqwjkeqjwehqjweqjhwegqhwe')
    icol_customer.save.should == false
    icol_customer.errors_on('name1').should == ["is longer than maximum (100)"]

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'date', setting1_value: '2014:12:12')
    icol_customer.save.should == false
    icol_customer.errors_on('name1').should == ["invalid format, the correct format is yyyy-mm-dd", "is not a date"]

    icol_customer = Factory.build(:icol_customer, setting1_name: 'name1', setting1_type: 'date', setting1_value: '2016-12-12')
    icol_customer.save.should == true
    icol_customer.errors_on('name1').should == []
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      icol_customer = Factory(:icol_customer, :approval_status => 'U')
      icol_customer.approve.save.should == true
      icol_customer.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      icol_customer = Factory(:icol_customer, :approval_status => 'A')
      icol_customer1 = Factory(:icol_customer, :approval_status => 'U', :approved_id => icol_customer.id, :approved_version => 6)
      icol_customer1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      icol_customer1 = Factory(:icol_customer, :approval_status => 'A')
      icol_customer2 = Factory(:icol_customer, :approval_status => 'U')
      icol_customer1.enable_approve_button?.should == false
      icol_customer2.enable_approve_button?.should == true
    end
  end
end
