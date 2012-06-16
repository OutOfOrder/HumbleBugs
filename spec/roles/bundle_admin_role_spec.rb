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
    include_examples 'can X to all', :create, :read, :update, :delete, :manage
  end

  context :games do
    include_examples 'can X to all', :create, :read, :update, :delete, :manage
  end

  context :predefined_tags do
    include_examples 'can X to all', :create, :read, :update, :delete, :manage
  end
end