class IcolCustomerSearcher < Searcher
  attr_searchable :page, :app_code, :customer_code, :approval_status
end