require 'spec_helper'

describe Issue do
  let(:game) { FactoryGirl.create :game }
  describe 'scopes' do
    describe '#open' do
      it 'should return issues in the open states' do
        open_issues = []
        Issue::OPEN_STATUSES.each do |status|
          open_issues << FactoryGirl.create(:issue, game: game, status: status.to_s)
        end
        (Issue::ALL_STATUSES - Issue::OPEN_STATUSES).each do |status|
          FactoryGirl.create(:issue, game: game, status: status.to_s)
        end

        Issue.open.should =~ open_issues
      end
    end
  end
end
