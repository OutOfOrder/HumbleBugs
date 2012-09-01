require 'spec_helper'

describe :user do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:user]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @user.destroy
  end

  it 'should have the user role' do
    Authorization.current_user.role_symbols.should == [:user]
  end

  context :bundles do
    it 'should be able to get a list of permissible bundles' do
      should be_allowed_to :index, true
    end

    it 'should be able to read active bundles' do
      bundle = FactoryGirl.create :bundle, :active
      bundle.should be_allowed_to :read
    end

    Bundle::STATES.each do |s|
      next if s.last == :active
      it "should not be able to read bundles in the #{s.last} state" do
        bundle = FactoryGirl.create :bundle, state: s.last.to_s
        bundle.should_not be_allowed_to :read
      end
    end

    include_examples 'can not X to any', :create, :update, :delete
  end

  context :developers do
    it 'can read but not address info for developers with games in an active bundle' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, :with_active_bundle, developer: developer

      developer.should be_allowed_to :read
      developer.should_not be_allowed_to :read_address
      developer.should_not be_allowed_to :update
      developer.should_not be_allowed_to :update_address
    end

    it 'can not read info about developers with games I can not read' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, developer: developer

      developer.should_not be_allowed_to :read
      developer.should_not be_allowed_to :read_address
      developer.should_not be_allowed_to :edit
      developer.should_not be_allowed_to :update_address
    end

    it 'can read address info for a developer I belong to' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, developer: developer
      @user.update_attribute(:developer_id, developer.id)

      developer.should be_allowed_to :read
      developer.should be_allowed_to :read_address
      developer.should be_allowed_to :update
      developer.should be_allowed_to :update_address
    end

    include_examples 'can not X to any', :create, :delete
  end

  context :games do
    it 'should be able to get a list of permissible games' do
      should be_allowed_to :index, true
    end
    it 'should be able to read those that are in an active bundle' do
      bundle = FactoryGirl.create :bundle, :active
      game = FactoryGirl.create :game, bundle: bundle
      game.should be_allowed_to :read
    end
    it 'should be able to read those for which they are the developer' do
      developer = FactoryGirl.create :developer
      @user.update_attribute(:developer_id, developer.id)
      game = FactoryGirl.create :game, developer: developer
      game.should be_allowed_to :read
    end
    Bundle::STATES.each do |s|
      next if s.last == :active
      it 'should not be able to read those that are in an #{s.last} bundle' do
        bundle = FactoryGirl.create :bundle, state: s.last.to_s
        game = FactoryGirl.create :game, bundle: bundle
        game.should_not be_allowed_to :read
      end
    end

    it 'can not read games in testing state' do
      game = FactoryGirl.create :game, :testing
      game.should_not be_allowed_to :read
    end

    include_examples 'can not X to any', :create, :update, :delete
  end

  context :issues do
    context 'for a game on an active bundle' do
      include_examples 'basic issues on' do
        let(:game) { FactoryGirl.create :game, :with_active_bundle }
      end
    end

    context 'for a game I am the developer on' do
      before do
        developer = FactoryGirl.create :developer
        @user.update_attribute(:developer_id, developer.id)
        @game = FactoryGirl.create :game, developer: developer
      end
      include_examples 'can X to this', :create, :read, :update do
        let(:this) { FactoryGirl.create :issue, game: @game }
      end
    end

    include_examples 'can not X to any', :delete
  end

  context :comments do
    context 'for an issue on a game in an active bundle' do
      include_examples 'basic comments on' do
        let(:commentable) { FactoryGirl.create :issue, game: FactoryGirl.create(:game, :with_active_bundle) }
      end
    end

    context 'for an issue on a game where I am the developer' do
      include_examples 'basic comments on' do
        let(:commentable) {
          developer = FactoryGirl.create :developer
          @user.update_attribute(:developer_id, developer.id)
          game = FactoryGirl.create :game, developer: developer
          FactoryGirl.create :issue, game: game
        }
      end
    end

  end

  context :ports do
    include_examples 'can not X to any', :create, :read, :update, :delete
  end

  context :predefined_tags do
    it 'should be able to read' do
      should be_allowed_to :read
    end
    include_examples 'can not X to any', :create, :update, :delete
  end

  context :releases do
    include_examples 'can not X to any', :create, :read, :update, :delete
  end

  context :test_results do
    include_examples 'can not X to any', :create, :read, :update, :delete
  end

  describe :users do
    include_examples 'edit my own user record'
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
      include_examples 'can not X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :system }
      end
    end
  end
end