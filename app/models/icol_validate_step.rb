class IcolValidateStep < ActiveRecord::Base
  lazy_load :up_req_header, :up_rep_header, :up_req_bitstream, :up_rep_bitstream, :req_bitstream, :rep_bitstream, :fault_bitstream

  def icol_customer
    IcolCustomer.find_by(customer_code: self.customer_code, template_code: self.template_code)
  end
end
