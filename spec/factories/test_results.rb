# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_result do
    user
    ignore do
      system :build
    end
    release
    rating "good"
    comments "My Comment"
    after(:build) do |test_result, evaluator|
      if evaluator.system == :build
        test_result.system = FactoryGirl.create(:system, user: test_result.user)
      else
        test_result.system = evaluator.system
      end
    end
  end
end
