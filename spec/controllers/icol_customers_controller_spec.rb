require 'spec_helper'

describe IcolCustomersController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET new" do
    it "assigns a new icol_customer as @icol_customer" do
      get :new
      assigns(:icol_customer).should be_a_new(IcolCustomer)
    end
  end

  describe "GET show" do
    it "assigns the requested icol_customer as @icol_customer" do
      icol_customer = Factory(:icol_customer)
      get :show, {:id => icol_customer.id}
      assigns(:icol_customer).should eq(icol_customer)
    end
  end
  
  describe "GET index" do
    it "assigns all icol_customers as @icol_customers" do
      icol_customer = Factory(:icol_customer, :approval_status => 'A')
      get :index
      assigns(:records).should eq([icol_customer])
    end
    
    it "assigns all unapproved icol_customers as @icol_customers when approval_status is passed" do
      icol_customer = Factory(:icol_customer, :approval_status => 'U')
      get :index, :approval_status => 'U'
      assigns(:records).should eq([icol_customer])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested icol_customer as @icol_customer" do
      icol_customer = Factory(:icol_customer, :approval_status => 'A')
      get :edit, {:id => icol_customer.id}
      assigns(:icol_customer).should eq(icol_customer)
    end
    
    it "assigns the requested icol_customer with status 'A' as @icol_customer" do
      icol_customer = Factory(:icol_customer,:approval_status => 'A')
      get :edit, {:id => icol_customer.id}
      assigns(:icol_customer).should eq(icol_customer)
    end

    it "assigns the new icol_customer with requested icol_customer params when status 'A' as @icol_customer" do
      icol_customer = Factory(:icol_customer,:approval_status => 'A')
      params = (icol_customer.attributes).merge({:approved_id => icol_customer.id,:approved_version => icol_customer.lock_version})
      get :edit, {:id => icol_customer.id}
      assigns(:icol_customer).should eq(IcolCustomer.new(params))
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested icol_customer" do
        icol_customer = Factory(:icol_customer, :notify_url => "http://localhost")
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => icol_customer.id, :icol_customer => params}
        icol_customer.reload
        icol_customer.notify_url.should == "https://www.google.com"
      end

      it "assigns the requested icol_customer as @icol_customer" do
        icol_customer = Factory(:icol_customer, :notify_url => "http://localhost")
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => icol_customer.to_param, :icol_customer => params}
        assigns(:icol_customer).should eq(icol_customer)
      end

      it "redirects to the icol_customer" do
        icol_customer = Factory(:icol_customer, :notify_url => "http://localhost")
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        put :update, {:id => icol_customer.to_param, :icol_customer => params}
        response.should redirect_to(icol_customer)
      end

      it "should raise error when tried to update at same time by many" do
        icol_customer = Factory(:icol_customer, :notify_url => "http://localhost")
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:notify_url] = "https://www.google.com"
        icol_customer2 = icol_customer
        put :update, {:id => icol_customer.id, :icol_customer => params}
        icol_customer.reload
        icol_customer.notify_url.should == "https://www.google.com"
        params[:notify_url] = "https://www.yahoo.com"
        put :update, {:id => icol_customer2.id, :icol_customer => params}
        icol_customer.reload
        icol_customer.notify_url.should == "https://www.google.com"
        flash[:alert].should  match(/Someone edited the customer the same time you did. Please re-apply your changes to the customer/)
      end
    end

    describe "with invalid params" do
      it "assigns the icol_customer as @icol_customer" do
        icol_customer = Factory(:icol_customer)
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:app_code] = nil
        put :update, {:id => icol_customer.to_param, :icol_customer => params}
        assigns(:icol_customer).should eq(icol_customer)
        icol_customer.reload
        params[:app_code] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        icol_customer = Factory(:icol_customer)
        params = icol_customer.attributes.slice(*icol_customer.class.attribute_names)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        put :update, {:id => icol_customer.id, :icol_customer => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new icol_customer" do
        params = Factory.attributes_for(:icol_customer)
        expect {
          post :create, {:icol_customer => params}
        }.to change(IcolCustomer.unscoped, :count).by(1)
        flash[:alert].should  match(/IcolCustomer successfully created and is pending for approval/)
        response.should be_redirect
      end

      it "assigns a newly created icol_customer as @icol_customer" do
        params = Factory.attributes_for(:icol_customer)
        post :create, {:icol_customer => params}
        assigns(:icol_customer).should be_a(IcolCustomer)
        assigns(:icol_customer).should be_persisted
      end

      it "redirects to the created icol_customer" do
        params = Factory.attributes_for(:icol_customer)
        post :create, {:icol_customer => params}
        response.should redirect_to(IcolCustomer.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved icol_customer as @icol_customer" do
        params = Factory.attributes_for(:icol_customer)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        expect {
          post :create, {:icol_customer => params}
        }.to change(IcolCustomer, :count).by(0)
        assigns(:icol_customer).should be_a(IcolCustomer)
        assigns(:icol_customer).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:icol_customer)
        params[:http_username] = 'abc'
        params[:http_password] = nil
        post :create, {:icol_customer => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      icol_customer1 = Factory(:icol_customer, :approval_status => 'A')
      icol_customer2 = Factory(:icol_customer, :approval_status => 'U', :notify_url => "http://localhost", :approved_version => icol_customer1.lock_version, :approved_id => icol_customer1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      icol_customer1.approval_status.should == 'A'
      UnapprovedRecord.count.should == 1
      put :approve, {:id => icol_customer2.id}
      UnapprovedRecord.count.should == 0
      icol_customer1.reload
      icol_customer1.notify_url.should == 'http://localhost'
      icol_customer1.updated_by.should == "666"
      UnapprovedRecord.find_by_id(icol_customer2.id).should be_nil
    end
  end
  
  describe "GET audit_logs" do
    it "assigns the requested icol_customer as @icol_customer" do
      icol_customer = Factory(:icol_customer)
      get :audit_logs, {:id => icol_customer.id, :version_id => 0}
      assigns(:record).should eq(icol_customer)
      assigns(:audit).should eq(icol_customer.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "i"}
      assigns(:record).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end
end
