require 'spec_helper'

describe :bundle_admin do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:bundle_admin]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @user.destroy
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

  context :comments do
    include_examples 'can X to this', :create, :read, :update, :delete do
      let(:this) { FactoryGirl.create :comment }
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
    include_examples 'can X to all', :create, :read, :update, :delete, :update_roles
    include_examples 'sign my nda' do
      let(:this) { @user }
    end
  end

  context :systems do
    context 'my systems' do
      include_examples 'can X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :system, user: @user }
      end
    end
    context 'other users systems' do
      include_examples 'can X to this', :read do
        let(:this) { FactoryGirl.create :system }
      end
      include_examples 'can not X to this', :create, :update, :delete do
        let(:this) { FactoryGirl.create :system }
      end
    end
  end
end