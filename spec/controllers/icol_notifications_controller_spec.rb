require 'spec_helper'

describe IcolNotificationsController do
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all notifications as @notifications" do
      notification = Factory(:icol_notification)
      get :index
      assigns(:records).should eq([notification])
    end
  end
  
  describe "GET show" do
    it "assigns the requested notification as @notification" do
      notification = Factory(:icol_notification)
      get :show, {:id => notification.id}
      assigns(:icol_notification).should eq(notification)
    end
  end
  
  describe "GET audit_steps" do
    it "assigns the steps of the requested notification" do
      notification1 = Factory(:icol_notification)
      step1 = Factory(:icol_notify_step, step_name: 'Validate', icol_notification_id: notification1.id)
      step2 = Factory(:icol_notify_step, step_name: 'Notify', icol_notification_id: notification1.id)
      step3 = Factory(:icol_notify_step, step_name: 'Valida', icol_notification_id: notification1.id)
      
      get :audit_steps, {:id => notification1.id}
      assigns(:steps).should eq([step3, step2, step1])
      
      notification2 = Factory(:icol_notification)
      get :audit_steps, {:id => notification2.id}
      assigns(:steps).should eq([])
    end
  end
end