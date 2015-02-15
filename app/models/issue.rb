class Issue < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :game, :inverse_of => :issues, :touch => true
  belongs_to :reported_against, :class_name => 'Release', :inverse_of => :reported_issues
  belongs_to :fixed_in, :class_name => 'Release', :inverse_of => :fixed_issues
  has_many :comments, :as => :commentable, :inverse_of => :commentable, :dependent => :destroy, :order => 'comments.created_at ASC'

  acts_as_taggable_on :platforms

  STATUSES = [
      ['New', :new],
      ['Waiting on Tester Feedback', :feedback],
      ['Waiting on Developer', :active],
      ['Won\'t fix', :suspended],
      ['Duplicate', :duplicate],
      ['Invalid', :invalid],
      ['Fixed', :fixed],
      ['Verified Fixed', :completed],
  ]

  OPEN_STATUSES = [:new, :feedback, :active]
  ALL_STATUSES = STATUSES.map { |m| m.second }

  PRIORITIES = [
      'Low' => 30,
      'Normal' => 50,
      'High' => 70,
      'Critical' => 90,
  ]

  validates :priority, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validates_presence_of :status, :description, :summary, :game_id, :author_id
  validates_inclusion_of :status, :in => ALL_STATUSES.map(&:to_s), :message => "%{value} is not a valid status"

  def self.open
    where(status: OPEN_STATUSES)
  end
end
