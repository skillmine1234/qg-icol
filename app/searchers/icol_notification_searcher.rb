class IcolNotificationSearcher < Searcher
  attr_searchable :page, :app_code, :customer_code, :txn_number, :status_code
  as_enum :status_code, [:NEW, :COMPLETED, :"IN PROCESS", :RETRYING, :"TIMED OUT", :FAILED ], map: :string, source: :status_code 
  # validates :txn_number, format: {with: /\A[\d]+\z/}, unless: "txn_number.blank?" 
end
