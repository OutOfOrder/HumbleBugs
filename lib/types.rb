module Types
  module Issue
    STATUSES = [
        ['New', :new],
        ['Waiting on Tester Feedback', :feedback],
        ['Waiting on Developer', :active],
        ['Won\'t fix', :suspended],
        ['Duplicate', :duplicate],
        ['Invalid', :invalid],
        ['Fixed', :fixed],
        ['Verified Fixed', :completed],
    ].freeze

    OPEN_STATUSES = [:new, :feedback, :active].freeze
    ALL_STATUSES = STATUSES.map { |m| m.second }.freeze
    CLOSED_STATUSES = (ALL_STATUSES - OPEN_STATUSES).freeze

    PRIORITIES = [
        ['Low', 30],
        ['Normal', 50],
        ['High', 70],
        ['Critical', 90],
    ].freeze
  end
end