require 'spec_helper'

describe :porter do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:porter]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @user.destroy
  end

  it 'should have the porter role' do
    Authorization.current_user.role_symbols.should == [:porter]
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
    include_examples 'can X to all', :read
    include_examples 'can not X to any', :create, :delete, :edit
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
    Bundle::STATES.each do |s|
      next if s.last == :active
      it 'should not be able to read those that are in an #{s.last} bundle' do
        bundle = FactoryGirl.create :bundle, state: s.last.to_s
        game = FactoryGirl.create :game, bundle: bundle
        game.should_not be_allowed_to :read
      end
    end

    it 'can read games in testing state' do
      game = FactoryGirl.create :game, :testing
      game.should_not be_allowed_to :read
    end

    it 'should be able to read games where I am the porter' do
      port = FactoryGirl.create :port, :porter => @user
      port.game.should be_allowed_to :read
    end
    it 'should not be able to read games where I am not the porter' do
      port = FactoryGirl.create :port
      port.game.should_not be_allowed_to :read
    end

    include_examples 'can not X to any', :create, :update, :delete
  end

  context :issues do
    context 'for a game on an active bundle' do
      include_examples 'basic issues on' do
        let(:game) { FactoryGirl.create :game, :with_active_bundle }
      end
    end

    context 'for a game I am porting' do
      before do
        @port = FactoryGirl.create :port, porter: @user
        @game = @port.game
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
    context 'for an issue on a game I am porting' do
      include_examples 'basic comments on' do
        let(:commentable) {
          port = FactoryGirl.create :port, porter: @user
          FactoryGirl.create :issue, game: port.game
        }
      end
    end
  end

  context :ports do
    context 'for a game on an active bundle' do
      include_examples 'can not X to this', :read, :update do
        let(:this) { FactoryGirl.create :port, game: FactoryGirl.create(:game, :with_active_bundle) }
      end
    end
    context 'for a game on I am porting' do
      before do
        @port = FactoryGirl.create :port, porter: @user
        @game = @port.game
      end
      it 'can read other ports' do
        port = FactoryGirl.create :port, game: @game
        port.should be_allowed_to :read
      end
      it 'can update my own port' do
        @port.should be_allowed_to :update
      end
      it 'can not update other ports' do
        port = FactoryGirl.create :port, game: @game
        port.should_not be_allowed_to :update
      end
    end
    context 'a bundle I am not porting nor in an active bundle' do
      include_examples 'can not X to this', :read, :update do
          let(:this) { FactoryGirl.create :port }
      end
    end
    include_examples 'can not X to any', :create, :delete
  end

  context :predefined_tags do
    it 'should be able to read' do
      should be_allowed_to :read
    end
    include_examples 'can not X to any', :create, :update, :delete
  end

  context :releases do
    context 'for a game on an active bundle' do
      include_examples 'can not X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :release, game: FactoryGirl.create(:game, :with_active_bundle) }
      end
    end
    context 'for a game in testing' do
      include_examples 'can not X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :release, game: FactoryGirl.create(:game, :testing) }
      end
    end

    context 'for a game on I am porting' do
      before do
        @port = FactoryGirl.create :port, porter: @user
        @game = @port.game
      end
      include_examples 'can X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :release, game: @game }
      end
    end
  end

  context :test_results do
    context 'for a game I am porting' do
      before do
        @port = FactoryGirl.create :port, porter: @user
        @game = @port.game
        @release = FactoryGirl.create :release, game: @game
      end
      include_examples 'can X to this', :read, :create do
        let(:this) { FactoryGirl.create :test_result, release: @release }
      end
      include_examples 'can not X to this', :edit, :delete do
        let(:this) { FactoryGirl.create :test_result, release: @release }
      end
      context 'for my own test result' do
        include_examples 'can X to this', :read, :create, :edit, :delete do
          let(:this) { FactoryGirl.create :test_result, release: @release, user: @user }
        end
      end
    end
  end

  context :users do
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