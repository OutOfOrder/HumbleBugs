require 'spec_helper'

describe :porter do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:porter]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
  end

  it 'should be able to read predefined tags' do
    should_be_allowed_to :read, :predefined_tags
  end

  it 'should be able to read games where I am the porter' do
    port = FactoryGirl.create :port, :porter => @user
    port2 = FactoryGirl.create :port
    game = FactoryGirl.create :game
    should_be_allowed_to :read, port.game
    should_not_be_allowed_to :read, port2.game
    should_not_be_allowed_to :read, game
  end
end