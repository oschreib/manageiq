require "spec_helper"
require_migration

describe ChangeOptionsInMiqAlert do

  migration_context :up do
    let(:miq_alert_stub) { migration_stub(:MiqAlert) }

    it 'default miq_alert email gets updated' do
      options = {:notifications => {:email => {:to => ['alert@manageiq.com']}}}
      alert = miq_alert_stub.create!(:description => 'Test Alert', :options => options)

      migrate

      alert.reload
      alert.options.should == {:notifications => {:email => {:to => ''}}}
    end

    it 'non-default miq_alert email is ignored' do
      options = {:notifications => {:email => {:to => ['alert@redhat.com']}}}
      alert = miq_alert_stub.create!(:description => 'Test Alert', :options => options)

      migrate

      alert.reload
      alert.options.should == options
    end
  end

end

