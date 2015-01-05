require 'spec_helper'

describe :developer do
  before :all do
    @user                      = FactoryGirl.create :user, :with_developer, :roles => [:user]
    @developer                 = @user.developer
    Authorization.current_user = @user
  end
  after :all do
    Authorization.current_user = nil
    @developer.destroy
    @user.destroy
  end

  it 'should have the user role' do
    expect(Authorization.current_user.role_symbols).to eq([:user])
    expect(@user.developer).not_to be_blank
  end

  context :developers do
    it 'can read address info for a developer I belong to' do
      expect(@developer).to be_allowed_to :read
      expect(@developer).to be_allowed_to :read_address
      expect(@developer).to be_allowed_to :update
      expect(@developer).to be_allowed_to :update_address
    end
  end

  context :games do
    it 'should be able to read those for which they are the developer' do
      game = FactoryGirl.create :game, developer: @developer
      expect(game).to be_allowed_to :read
    end
  end

  context :issues do
    context 'for a game I am the developer on' do
      before do
        @game = FactoryGirl.create :game, developer: @developer
      end
      include_examples 'can X to this', :create, :read, :update do
        let(:this) { FactoryGirl.create :issue, game: @game }
      end
    end
  end

  context :comments do
    context 'for an issue on a game where I am the developer' do
      before do
        @game = FactoryGirl.create :game, developer: @developer
      end
      include_examples 'basic comments on' do
        let(:commentable) {
          FactoryGirl.create :issue, game: @game
        }
      end
    end
  end

  context :ports do
    context 'for a game on I am the developer' do
      before do
        @game = FactoryGirl.create :game, developer: @developer
      end
      it 'can read ports' do
        port = FactoryGirl.create :port, game: @game
        expect(port).to be_allowed_to :read
      end
      it 'can not update ports' do
        port = FactoryGirl.create :port, game: @game
        expect(port).not_to be_allowed_to :update
      end
    end
  end

  context :releases do
    context 'for a game on I am the developer' do
      before do
        @game = FactoryGirl.create :game, developer: @developer
      end
      include_examples 'can X to this', :read, :create, :update, :delete do
        let(:this) { FactoryGirl.create :release, game: @game }
      end
    end
  end

  context :test_results do
    context 'for a game I am the developer' do
      before do
        @game    = FactoryGirl.create :game, developer: @developer
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
end

