IcolCustomer.seed_once(:customer_code, :template_code) do |s|
  s.customer_code = '22'
  s.customer_name = 'HUDA'
  s.app_code = 'HUDABP'
  s.validate_url = 'http://59.145.173.88:8081/Service.asmx'
  s.notify_url = 'http://59.145.173.88:8081/Service.asmx'
  s.http_username = nil
  s.http_password = nil
  s.template_code = 30
  s.setting1_name  = 'clientCode'
  s.setting1_type  = 'text'
  s.setting1_value = 'YESBANK'
  s.setting2_name  = 'userId'
  s.setting2_type  = 'text'
  s.setting2_value = 'HUDA_YESBANK'
  s.setting3_name  = 'userPassword'
  s.setting3_type  = 'text'
  s.setting3_value = 'yesbank@123'
  s.setting4_name  = 'paymentType'
  s.setting4_type  = 'text'
  s.setting4_value = 'BILLPAYMENT'
  s.setting5_name  = 'bankName'
  s.setting5_type  = 'text'
  s.setting5_value = 'YesBank'
  s.setting6_name  = 'towards'
  s.setting6_type  = 'text'
  s.setting6_value = 'BILL PAYMENT'  
  s.created_by = 'Q'
  s.approval_status = 'A'
end

IcolCustomer.seed_once(:customer_code, :template_code) do |s|
  s.customer_code = '22'
  s.customer_name = 'HUDA'
  s.app_code = 'HUDAVP'
  s.validate_url = 'http://59.145.173.88:8081/Service.asmx'
  s.notify_url = 'http://59.145.173.88:8081/Service.asmx'
  s.http_username = nil
  s.http_password = nil
  s.template_code = 31
  s.setting1_name  = 'clientCode'
  s.setting1_type  = 'text'
  s.setting1_value = 'YESBANK'
  s.setting2_name  = 'userId'
  s.setting2_type  = 'text'
  s.setting2_value = 'HUDA_YESBANK'
  s.setting3_name  = 'userPassword'
  s.setting3_type  = 'text'
  s.setting3_value = 'yesbank@123'
  s.setting4_name  = 'paymentType'
  s.setting4_type  = 'text'
  s.setting4_value = 'VOUCHERPAYMENT'
  s.setting5_name  = 'bankName'
  s.setting5_type  = 'text'
  s.setting5_value = 'YesBank'
  s.created_by = 'Q'
  s.approval_status = 'A'
end