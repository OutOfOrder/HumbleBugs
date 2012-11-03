# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :port do
    association :game
    association :developer
    state "planned"

    ignore do
      porter nil
    end
    after(:build) do |port, evaluator|
      raise "Update spec to use new port schema" unless evaluator.porter.nil?
    end
  end
end
