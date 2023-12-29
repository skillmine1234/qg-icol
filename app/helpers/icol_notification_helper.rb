module IcolNotificationHelper

	def find_icol_notifications(params)
    icol_notifications = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcolNotification.unscoped : IcolNotification
    icol_notifications = icol_notifications.where("app_code IN (?)", params[:app_code].split(",").collect(&:strip)) if params[:app_code].present?
    icol_notifications = icol_notifications.where("customer_code IN (?)", params[:customer_code].split(",").collect(&:strip)) if params[:customer_code].present?
    icol_notifications = icol_notifications.where("txn_number IN (?)", params[:txn_number].split(",").collect(&:strip)) if params[:txn_number].present?
    icol_notifications = icol_notifications.where("status_code = ?", params[:status_code]) if params[:status_code].present?
    icol_notifications
  end

end