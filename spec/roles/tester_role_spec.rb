require 'spec_helper'

describe :tester do
  before :all do
    @user = FactoryGirl.create :user, :roles => [:tester]
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @user.destroy
  end

  it 'should have the tester role' do
    expect(Authorization.current_user.role_symbols).to eq([:tester])
  end

  context :bundles do
    it 'should be able to get a list of permissible bundles' do
      is_expected.to be_allowed_to :index, true
    end

    it 'should be able to read active bundles' do
      bundle = FactoryGirl.create :bundle, :active
      expect(bundle).to be_allowed_to :read
    end

    Types::Bundle::STATES.each do |s|
      next if s.last == :active
      it "should not be able to read bundles in the #{s.last} state" do
        bundle = FactoryGirl.create :bundle, state: s.last.to_s
        expect(bundle).not_to be_allowed_to :read
      end
    end

    include_examples 'can not X to any', :create, :update, :delete
  end

  context :developers do
    it 'can read but not address info for developers with games in an active bundle' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, :with_active_bundle, developer: developer

      expect(developer).to be_allowed_to :read
      expect(developer).not_to be_allowed_to :read_address
    end

    it 'can read but not address info for developers with games in testing' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, :testing, developer: developer

      expect(developer).to be_allowed_to :read
      expect(developer).not_to be_allowed_to :read_address
    end

    it 'can not read info about developers with games I can not read' do
      developer = FactoryGirl.create :developer
      FactoryGirl.create :game, developer: developer

      expect(developer).not_to be_allowed_to :read
      expect(developer).not_to be_allowed_to :read_address
    end

    include_examples 'can not X to any', :create, :delete
  end

  context :games do
    it 'should be able to get a list of permissible games' do
      is_expected.to be_allowed_to :index, true
    end
    it 'should be able to read those that are in an active bundle' do
      bundle = FactoryGirl.create :bundle, :active
      game = FactoryGirl.create :game, bundle: bundle
      expect(game).to be_allowed_to :read
    end
    Types::Bundle::STATES.each do |s|
      next if s.last == :active
      it 'should not be able to read those that are in an #{s.last} bundle' do
        bundle = FactoryGirl.create :bundle, state: s.last.to_s
        game = FactoryGirl.create :game, bundle: bundle
        expect(game).not_to be_allowed_to :read
      end
    end

    it 'can read games in testing state' do
      game = FactoryGirl.create :game, :testing
      expect(game).to be_allowed_to :read
    end

    include_examples 'can not X to any', :create, :update, :delete
  end

  context :issues do
    context 'for a game on an active bundle' do
      include_examples 'basic issues on' do
        let(:game) { FactoryGirl.create :game, :with_active_bundle }
      end
    end

    context 'for a game in testing' do
      include_examples 'basic issues on' do
        let(:game) { FactoryGirl.create :game, :testing }
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
    context 'for an issue on a game in testing' do
      include_examples 'basic comments on' do
        let(:commentable) { FactoryGirl.create :issue, game: FactoryGirl.create(:game, :testing) }
      end
    end
  end

  context :ports do
    context 'for a game on an active bundle' do
      include_examples 'can not X to this', :read, :update do
        let(:this) { FactoryGirl.create :port, game: FactoryGirl.create(:game, :with_active_bundle) }
      end
    end
    context 'for a game in testing' do
      include_examples 'can X to this', :read do
        let(:this) { FactoryGirl.create :port, game: FactoryGirl.create(:game, :testing) }
      end
      include_examples 'can not X to this', :update do
        let(:this) { FactoryGirl.create :port, game: FactoryGirl.create(:game, :testing) }
      end
    end
    include_examples 'can not X to any', :create, :delete
  end

  context :predefined_tags do
    it 'should be able to read' do
      is_expected.to be_allowed_to :read
    end
    include_examples 'can not X to any', :create, :update, :delete
  end

  context :releases do
    context 'for a game on an active bundle' do
      include_examples 'can X to this', :read do
        let(:this) { FactoryGirl.create :release, game: FactoryGirl.create(:game, :with_active_bundle) }
      end
    end
    context 'for a game in testing' do
      include_examples 'can X to this', :read do
        let(:this) { FactoryGirl.create :release, game: FactoryGirl.create(:game, :testing) }
      end
    end
  end

  context :test_results do
    context 'for a game on an active bundle' do
      before do
        @game = FactoryGirl.create :game, :with_active_bundle
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
    context 'for a game in testing' do
      before do
        @game = FactoryGirl.create :game, :testing
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