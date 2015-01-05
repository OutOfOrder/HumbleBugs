require 'spec_helper'

describe :admin do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:admin]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @user.destroy
  end

  it 'should have the admin role' do
    expect(Authorization.current_user.role_symbols).to eq([:admin])
  end

  #admin has omnipotence so do we really need to test anything?
end