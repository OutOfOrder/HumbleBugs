require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'scopes' do
    describe '#with_role' do
      it 'should return users in the scope specified' do
        users = FactoryGirl.create_list :user, 2, :roles => [:good]
        FactoryGirl.create_list :user, 2, :roles => [:other]
        User.with_role(:good).should =~ users
      end
    end
  end
end
