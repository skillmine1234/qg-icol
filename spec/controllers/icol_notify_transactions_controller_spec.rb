require 'spec_helper'

describe IcolNotifyTransactionsController do
  include HelperMethods

  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
    request.env["CONFIG_ENVIRONMENT"] = "test"
  end


  describe "GET index" do
    it "assigns all icol_notify_transactions as @icol_notify_transactions" do
      icol_notify_transaction = Factory(:icol_notify_transaction)
      get :index
      assigns(:icol_notify_transactions).should eq([icol_notify_transaction])
    end
  end

  describe "GET show" do
    it "assigns the requested icol_notify_transaction as @icol_notify_transaction" do
      icol_notify_transaction = Factory(:icol_notify_transaction)
      get :show, {:id => icol_notify_transaction.id}
      assigns(:icol_notify_transaction).should eq(icol_notify_transaction)
    end
  end

  describe "GET new" do
    it "assigns a new icol_notify_transaction as @icol_notify_transaction" do
      get :new
      assigns(:icol_notify_transaction).should be_a_new(IcolNotifyTransaction)
    end
  end

  describe "GET edit" do
    it "assigns the requested icol_notify_transaction as @icol_notify_transaction" do
      @icol_notify_transaction = Factory(:icol_notify_transaction)
      get :edit, {:id => @icol_notify_transaction.id}
      assigns(:icol_notify_transaction).should eq(@icol_notify_transaction)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new icol_notify_transaction" do
        params = Factory.attributes_for(:icol_notify_transaction)
        expect {
          post :create, {:icol_notify_transaction => params}
        }.to change(IcolNotifyTransaction.all, :count).by(1)
        flash[:alert].should  match(/Notify Transaction successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created icol_notify_transaction as @icol_notify_transaction" do
        params = Factory.attributes_for(:icol_notify_transaction)
        post :create, {:icol_notify_transaction => params}
        assigns(:icol_notify_transaction).should be_a(IcolNotifyTransaction)
        assigns(:icol_notify_transaction).should be_persisted
      end

      it "redirects to the icol_notify_transactions list" do
        params = Factory.attributes_for(:icol_notify_transaction)
        post :create, {:icol_notify_transaction => params}
        response.should redirect_to(icol_notify_transactions_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved icol_notify_transaction as @icol_notify_transaction" do
        params = Factory.attributes_for(:icol_notify_transaction)
        params[:payment_status] = nil
        expect {
          post :create, {:icol_notify_transaction => params}
        }.to change(IcolNotifyTransaction.all, :count).by(0)
        assigns(:icol_notify_transaction).should be_a(IcolNotifyTransaction)
        assigns(:icol_notify_transaction).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:icol_notify_transaction)
        params[:payment_status] = nil
        post :create, {:icol_notify_transaction => params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested icol_notify_transaction" do
        icol_notify_transaction = Factory(:icol_notify_transaction, :payment_status => "ABC")
        params = icol_notify_transaction.attributes.slice(*icol_notify_transaction.class.attribute_names)
        params[:payment_status] = "ABC"
        put :update, {:id => icol_notify_transaction.id, :icol_notify_transaction => params}
        icol_notify_transaction.reload
        icol_notify_transaction.payment_status.should == "ABC"
      end

      it "assigns the requested icol_notify_transaction as @icol_notify_transaction" do
        icol_notify_transaction = Factory(:icol_notify_transaction, :payment_status => "ABC")
        params = icol_notify_transaction.attributes.slice(*icol_notify_transaction.class.attribute_names)
        params[:payment_status] = "ABC"
        put :update, {:id => icol_notify_transaction.to_param, :icol_notify_transaction => params}
        assigns(:icol_notify_transaction).should eq(icol_notify_transaction)
      end

      it "redirects to the icol_notify_transaction list" do
        icol_notify_transaction = Factory(:icol_notify_transaction, :payment_status => "ABC")
        params = icol_notify_transaction.attributes.slice(*icol_notify_transaction.class.attribute_names)
        params[:payment_status] = "ABC"
        put :update, {:id => icol_notify_transaction.to_param, :icol_notify_transaction => params}
        response.should redirect_to(icol_notify_transactions_url)
      end
    end
  end

  describe "destroy" do
    it "should destroy the icol_notify_transaction" do 
      icol_notify_transaction = Factory(:icol_notify_transaction)
      expect {delete :destroy, {:id => icol_notify_transaction.id}}.to change(IcolNotifyTransaction, :count).by(-1)
      IcolNotifyTransaction.find_by_trnsctn_nmbr(icol_notify_transaction.id).should be_nil
    end

    it "redirects to the icol_notify_transaction list" do
      icol_notify_transaction = Factory(:icol_notify_transaction)
      delete :destroy, {:id => icol_notify_transaction.id}
      response.should redirect_to(icol_notify_transactions_url)
    end
  end

end