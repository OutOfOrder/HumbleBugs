require 'spec_helper'

describe :bundle_admin do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:bundle_admin]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
  end

  it 'should have the bundle_admin role' do
    Authorization.current_user.role_symbols.should == [:bundle_admin]
  end

  context :bundles do
    include_examples 'can X to all', :create, :read, :update, :delete
  end

  context :games do
    include_examples 'can X to all', :create, :read, :update, :delete
  end

  context :issues do
    include_examples 'can X to this', :create, :read, :update, :delete do
      let(:this) { FactoryGirl.create :issue }
    end
  end

  context :notes do
    include_examples 'can X to this', :create, :read, :update, :delete do
      let(:this) { FactoryGirl.create :note }
    end
  end

  context :ports do
    include_examples 'can X to this', :create, :read, :update, :delete do
      let(:this) { FactoryGirl.create :port }
    end
  end

  context :predefined_tags do
    include_examples 'can X to all', :create, :read, :update, :delete
  end

  context :releases do
    include_examples 'can X to this', :create, :read, :update, :delete do
      let(:this) { FactoryGirl.create :release }
    end
  end

  context :users do
    include_examples 'can X to all', :create, :read, :update, :delete
  end
end