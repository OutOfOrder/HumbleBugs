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

  describe '#send_confirm_account' do
    it 'should generate a new confirm account token' do
      user = FactoryGirl.create :user
      expect {
        user.send_confirm_account
      }.to change(user, :confirm_account_token)
    end
  end

  describe '#send_password_reset' do
    it 'should generate a new password reset token' do
      user = FactoryGirl.create :user
      expect {
        user.send_password_reset
      }.to change(user, :password_reset_token)
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
