require "qg/icol/engine"

module Qg
  module Icol
    NAME = 'ICollect'
    GROUP = 'icol'
    MENU_ITEMS = [:icol_customer, :icol_validate_step, :icol_notification]
    MODELS = ['IcolCustomer', 'IcolValidateStep', 'IcolNotification', 'IcolNotifyStep', 'IcolNotifyTransaction']
    TEST_MENU_ITEMS = [:icol_notify_transaction]
  end
end