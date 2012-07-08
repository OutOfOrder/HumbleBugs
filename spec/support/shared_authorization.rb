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

shared_examples "can not X to this" do |*privileges|
  privileges.each do |privilege|
    it "should not be able to #{privilege}" do
      this.should_not be_allowed_to privilege
    end
  end
end

shared_examples "can X to this" do |*privileges|
  privileges.each do |privilege|
    it "should be able to #{privilege}" do
      this.should be_allowed_to privilege
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

shared_examples 'basic issues on' do
  it 'should be able to create' do
    game.issues.build.should be_allowed_to :create
  end

  it 'should be able to update ones I created' do
    issue = FactoryGirl.create :issue, game: game, author: Authorization.current_user
    issue.should be_allowed_to :update
  end

  it 'should be able to read other issues' do
    issue = FactoryGirl.create :issue, game: game
    issue.should be_allowed_to :read
  end

  it 'should not be able to update ones I did not create' do
    issue = FactoryGirl.create :issue, game: game
    issue.should_not be_allowed_to :update
  end
end

shared_examples 'basic comments on' do
  include_examples 'can X to this', :read, :create do
    let(:this) { FactoryGirl.create :comment, commentable: commentable }
  end
  context 'for a comment I created' do
    include_examples 'can X to this', :read, :update do
      let(:this) { FactoryGirl.create :comment, author: Authorization.current_user, commentable: commentable }
    end
  end
end