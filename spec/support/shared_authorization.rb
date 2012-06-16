shared_examples "can not X to any" do |*privileges|
  privileges.each do |privilege|
    it "should not be able to #{privilege} any" do
      should_not be_allowed_to privilege, true
    end
  end
end

shared_examples "can X to all" do |*privileges|
  privileges.each do |privilege|
    it "should be able to #{privilege} all" do
      should be_allowed_to privilege
    end
  end
end

shared_examples "edit my own user record" do
  context 'my user record' do
    subject { Authorization.current_user }
    it 'passed user is valid' do
      subject.should be_a User
    end
    it 'can read' do
      subject.should be_allowed_to :read
    end
    it 'can update' do
      subject.should be_allowed_to :update
    end
  end
  context 'other users' do
    [:read, :update].each do |p|
      it "can not #{p}" do
        user = FactoryGirl.create :user
        user.should_not be_allowed_to p
      end
    end
  end
  include_examples 'can not X to any', :create, :delete
end
