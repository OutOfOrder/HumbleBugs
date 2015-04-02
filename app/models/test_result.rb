class TestResult < ActiveRecord::Base
  belongs_to :user, :inverse_of => :test_results
  belongs_to :system, :inverse_of => :test_results
  belongs_to :release, :inverse_of => :test_results, :touch => true

  attr_accessible :comments, :rating, :system_id

  validates_presence_of :user_id, :system_id, :release_id

  validates_inclusion_of :rating, :in => Types::TestResult::ALL_RATINGS.map(&:to_s), :message => "%{value} is not a valid rating"
  validates_uniqueness_of :system_id, :scope => [:release_id]
end
