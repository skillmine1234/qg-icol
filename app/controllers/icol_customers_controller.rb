class IcolCustomersController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json
  include Approval2::ControllerAdditions
  include ApplicationHelper
  include IcolCustomerHelper

  def new
    @icol_customer = IcolCustomer.new
  end

  def create
    @icol_customer = IcolCustomer.new(icol_customer_params)
    if !@icol_customer.valid?
      render "new"
    else
      @icol_customer.created_by = current_user.id
      @icol_customer.save!
      flash[:alert] = 'IcolCustomer successfully created and is pending for approval'
      redirect_to @icol_customer
    end
  end

  def update
    @icol_customer = IcolCustomer.unscoped.find_by_id(params[:id])
    @icol_customer.attributes = params[:icol_customer]
    if !@icol_customer.valid?
      render "edit"
    else
      @icol_customer.updated_by = current_user.id
      @icol_customer.save!
      flash[:alert] = 'IcolCustomer successfully modified successfully'
      redirect_to @icol_customer
    end
    rescue ActiveRecord::StaleObjectError
      @icol_customer.reload
      flash[:alert] = 'Someone edited the customer the same time you did. Please re-apply your changes to the customer.'
      render "edit"
  end 

  def show
    @icol_customer = IcolCustomer.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      icol_customers = find_icol_customers(params).order("id DESC")
    else
      icol_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcolCustomer.unscoped.where("approval_status =?",'U').order("id desc") : IcolCustomer.order("id desc")
    end
    @icol_customers = icol_customers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @record = IcolCustomer.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    redirect_to unapproved_records_path(group_name: 'icol')
  end

  private    
    def search_params
      params.require(:icol_customer_searcher).permit( :page, :app_code, :customer_code, :approval_status)
    end 


  def icol_customer_params
    params.require(:icol_customer).permit(:customer_code, :customer_name, :app_code, :settings_cnt,
    :lock_version, :last_action, :updated_by, :notify_url, :validate_url, 
    :http_username, :http_password, :approval_status, :approved_version, 
    :approved_id, :max_retries_for_notify, :retry_notify_in_mins, :template_code, :use_proxy, :is_enabled, 
    :setting1_name, :setting1_type, :setting1_value, 
    :setting2_name, :setting2_type, :setting2_value, 
    :setting3_name, :setting3_type, :setting3_value, 
    :setting4_name, :setting4_type, :setting4_value,
    :setting5_name, :setting5_type, :setting5_value,
    :setting6_name, :setting6_type, :setting6_value, 
    :setting7_name, :setting7_type, :setting7_value, 
    :setting8_name, :setting8_type, :setting8_value, 
    :setting9_name, :setting9_type, :setting9_value,
    :setting10_name, :setting10_type, :setting10_value
    )
  end
end
