class IcolNotificationsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IcolNotificationHelper

  def index
    if params[:advanced_search].present?
      icol_notifications = find_icol_notifications(params).order("id DESC")
    else
      icol_notifications = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcolNotification.unscoped.where("approval_status =?",'U').order("id desc") : IcolNotification.order("id desc")
    end
    @icol_notifications = icol_notifications.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @icol_notification = IcolNotification.find(params[:id])
  end
  
  def audit_steps
    icol_notification = IcolNotification.find(params[:id])
    steps = icol_notification.icol_notify_steps
    @steps = steps.order("id desc").paginate(page: params[:page], per_page: 10)
  end
  
  private    
    def search_params
      params.require(:icol_notification_searcher).permit( :page, :app_code, :customer_code, :txn_number, :status_code,:approval_status)
    end
end