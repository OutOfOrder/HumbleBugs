require 'spec_helper'

describe ReleaseHelper do
  let(:user_tester) { FactoryGirl.create :user, roles: [:tester] }
  let(:user_bundle_admin) { FactoryGirl.create :user, roles: [:bundle_admin] }
  let(:developer) { FactoryGirl.create :developer }
  let(:user_developer) { FactoryGirl.create :user, roles: [:user], developer: developer}
  let(:game) { FactoryGirl.create :game, :testing, developer: developer }

  before do
    allow(controller).to receive(:current_user) { Authorization.current_user }
  end

  describe ".available_release_statuses" do
    it 'returns all statuses for a bundle admin' do
      with_user(user_bundle_admin) do
        expect(game.releases).to be_allowed_to(:manage)
        expect(helper.available_release_statuses(game).size).to eq(Types::Release::STATUSES.size)
      end
    end

    it 'returns all statuses for a developer of the game' do
      with_user(user_developer) do
        expect(game.releases).to be_allowed_to(:manage)
        expect(helper.available_release_statuses(game).size).to eq(Types::Release::STATUSES.size)
      end
    end

    it 'returns limited statuses for a tester' do
      with_user(user_tester) do
        expect(game.releases).to_not be_allowed_to(:manage)
        expect(game.releases).to be_allowed_to(:read)
        expect(helper.available_release_statuses(game).size).to eq(Types::Release::TESTER_STATUSES.size)
      end
    end
  end
end
