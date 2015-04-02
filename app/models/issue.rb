class Issue < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :game, :inverse_of => :issues, :touch => true
  belongs_to :reported_against, :class_name => 'Release', :inverse_of => :reported_issues
  belongs_to :fixed_in, :class_name => 'Release', :inverse_of => :fixed_issues
  has_many :comments, :as => :commentable, :inverse_of => :commentable, :dependent => :destroy, :order => 'comments.created_at ASC'

  acts_as_taggable_on :platforms

  STATUSES = Types::Issue::STATUSES

  OPEN_STATUSES = Types::Issue::OPEN_STATUSES
  ALL_STATUSES = Types::Issue::ALL_STATUSES
  CLOSED_STATUSES = Types::Issue::CLOSED_STATUSES

  PRIORITIES = Types::Issue::PRIORITIES

  validates :priority, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validates_presence_of :status, :description, :summary, :game_id, :author_id
  validates_inclusion_of :status, :in => ALL_STATUSES.map(&:to_s), :message => "%{value} is not a valid status"

  def self.open
    where(status: OPEN_STATUSES)
  end
end
