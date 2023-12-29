module IcolValidateStepHelper

	def find_icol_validate_steps(params)
    icol_validate_steps = IcolValidateStep.order("id desc")
    icol_validate_steps = icol_validate_steps.where("app_code IN (?)", params[:app_code].split(",").collect(&:strip)) if params[:app_code].present?
    icol_validate_steps = icol_validate_steps.where("customer_code IN (?)", params[:customer_code].split(",").collect(&:strip)) if params[:customer_code].present?
    icol_validate_steps = icol_validate_steps.where("step_name IN (?)", params[:step_name].split(",").collect(&:strip)) if params[:step_name].present?
    icol_validate_steps = icol_validate_steps.where("status_code = ?", params[:status_code]) if params[:status_code].present?
    icol_validate_steps = icol_validate_steps.where("req_timestamp>=? and req_timestamp<=?",Time.zone.parse(params[:from_req_timestamp]).beginning_of_day,Time.zone.parse(params[:to_req_timestamp]).end_of_day) if params[:from_req_timestamp].present? and params[:to_req_timestamp].present?
    icol_validate_steps = icol_validate_steps.where("rep_timestamp>=? and rep_timestamp<=?",Time.zone.parse(params[:from_rep_timestamp]).beginning_of_day,Time.zone.parse(params[:to_rep_timestamp]).end_of_day) if params[:from_rep_timestamp].present? and params[:to_rep_timestamp].present?
    icol_validate_steps
  end

end