module IcolCustomerHelper

	def find_icol_customers(params)
    icol_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcolCustomer.unscoped : IcolCustomer
    icol_customers = icol_customers.where("app_code IN (?)", params[:app_code].split(",").collect(&:strip)) if params[:app_code].present?
    icol_customers = icol_customers.where("customer_code IN (?)", params[:customer_code].split(",").collect(&:strip)) if params[:customer_code].present?
    icol_customers = icol_customers.where("step_name IN (?)", params[:step_name].split(",").collect(&:strip)) if params[:step_name].present?
    icol_customers
  end

end