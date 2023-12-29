class IcolValidateStepsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IcolValidateStepHelper

  def index
    if params[:advanced_search].present?
      icol_validate_steps = find_icol_validate_steps(params).order("id DESC")
    else
      icol_validate_steps = IcolValidateStep.order("id desc")
    end
    @icol_validate_steps = icol_validate_steps.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @validate_step = IcolValidateStep.find_by_id(params[:id])
  end
  
  private    
    def search_params
      params.require(:icol_validate_step_searcher).permit( :page, :app_code, :customer_code, :step_name, :status_code, :from_req_timestamp, :to_req_timestamp, :from_rep_timestamp, :to_rep_timestamp)
    end
end
