require 'spec_helper'

describe IcolNotifyStep do

  context 'association' do
    it { should belong_to(:icol_notification) }
  end
end