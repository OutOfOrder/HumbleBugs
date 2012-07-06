require 'spec_helper'

describe User do
  describe 'scopes' do
    describe '#with_role' do
      it 'should return users in the scope specified' do
        users = FactoryGirl.create_list :user, 2, :roles => [:good]
        FactoryGirl.create_list :user, 2, :roles => [:other]
        User.with_role(:good).should =~ users
      end
    end
  end

  describe 'validations' do
    it 'duplicate mixed case emails' do
      user = FactoryGirl.create :user

      user2 = FactoryGirl.build :user, :email => user.email.upcase

      user2.should have(1).errors_on(:email)

      user.email.should_not == user2.email
    end
  end
end
