require 'spec_helper'

describe IcolNotification do
  context 'association' do
    it { should have_many(:icol_notify_steps) }
    it { should belong_to(:icol_customer) }
  end
end