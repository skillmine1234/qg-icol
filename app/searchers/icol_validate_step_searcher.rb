class IcolValidateStepSearcher < Searcher
  attr_searchable :page, :app_code, :customer_code, :step_name, :status_code, :from_req_timestamp, :to_req_timestamp, :from_rep_timestamp, :to_rep_timestamp
  as_enum :status_code, [:NEW, :COMPLETED, :"TIMED OUT", :FAILED ], map: :string, source: :status_code
  
  def find
    reln = IcolValidateStep.order('id desc')
    reln = reln.where("req_timestamp >= ? and req_timestamp <= ?", Time.zone.parse(from_req_timestamp).beginning_of_day,Time.zone.parse(to_req_timestamp).beginning_of_day) if from_req_timestamp.present? and to_req_timestamp.present?
    reln = reln.where("rep_timestamp >= ? and rep_timestamp <= ?", Time.zone.parse(from_rep_timestamp).beginning_of_day,Time.zone.parse(to_rep_timestamp).beginning_of_day) if from_rep_timestamp.present? and to_rep_timestamp.present?
    reln
  end
  
end