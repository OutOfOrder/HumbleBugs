require 'spec_helper'

describe Issue do
  let(:game) { FactoryGirl.create :game }
  describe 'scopes' do
    describe '#open' do
      it 'should return issues in the open states' do
        open_issues = []
        Types::Issue::OPEN_STATUSES.each do |status|
          open_issues << FactoryGirl.create(:issue, game: game, status: status.to_s)
        end
        (Types::Issue::ALL_STATUSES - Types::Issue::OPEN_STATUSES).each do |status|
          FactoryGirl.create(:issue, game: game, status: status.to_s)
        end

        expect(Issue.open).to match_array(open_issues)
      end
    end
  end

  describe 'validations' do
    it 'should be invalid with a priority less than zero' do
      issue = FactoryGirl.build :issue, game: game, priority: -1
      expect(issue).to_not be_valid
    end
    it 'should be invalid with a priority greater than 100' do
      issue = FactoryGirl.build :issue, game: game, priority: 101
      expect(issue).to_not be_valid
    end
    it 'should be valid with a priority in range' do
      issue = FactoryGirl.build :issue, game: game, priority: 50
      expect(issue).to be_valid
    end
  end
end
