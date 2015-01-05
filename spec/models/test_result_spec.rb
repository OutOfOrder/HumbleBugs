require 'spec_helper'

describe TestResult do
  describe 'validations' do
    it 'prevent duplicate test results for the same system' do
      tr = FactoryGirl.create :test_result, rating: 'good'

      tr2 = FactoryGirl.build :test_result, release: tr.release, user: tr.user, system: tr.system, rating: 'poor'
      tr2.valid?(:create)
      expect(tr2.errors[:system_id].size).to eq(1)
    end
  end
end
