module Types

  module Bundle
    STATES = [
        ['Planned', :planned],
        ['In Development', :development],
        ['Pending Release', :pending],
        ['Active', :active],
        ['Completed', :completed]
    ].freeze

    ALL_STATES = STATES.map { |m| m.second }.freeze
  end

  module Game
    STATES = [
        ['Prospective', :prospective],
        ['Planned', :planned],
        ['In Development', :development],
        ['QA Testing', :testing],
        ['Completed', :completed]
    ].freeze

    ALL_STATES = STATES.map { |m| m.second }.freeze
    TESTER_STATUSES = [:testing, :complete]
  end

  module Port
    STATES = [
        ['Planned', :planned],
        ['In Development', :development],
        ['Completed', :completed]
    ].freeze

    ALL_STATES = STATES.map { |m| m.second }.freeze
  end

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

    ALL_STATUSES = STATUSES.map { |m| m.second }.freeze
    OPEN_STATUSES = [:new, :feedback, :active].freeze
    CLOSED_STATUSES = (ALL_STATUSES - OPEN_STATUSES).freeze

    PRIORITIES = [
        ['Low', 30],
        ['Normal', 50],
        ['High', 70],
        ['Critical', 90],
    ].freeze

    ALL_PRIORITIES = PRIORITIES.map { |m| m.second }.freeze
  end

  module Release
    STATUSES = [
        ['Active', :active],
        ['Obsolete', :obsolete],
        ['Retired', :retired]
    ].freeze

    ALL_STATUSES = STATUSES.map { |m| m.second }.freeze
    TESTER_STATUSES = [:active, :obsolete]
  end

  module TestResult
    RATINGS = [
        ['Does not run', :does_not_run],
        ['Poor', :poor],
        ['Good',:good],
        ['Excellent', :excellent],
    ].freeze

    ALL_RATINGS = RATINGS.map { |m| m.second }.freeze
  end

  module PredefinedTag
    CONTEXTS = [
        ['Platforms', :platforms],
    ]
    CONTEXTS << ['Test', :testing] if Rails.env.test?
    CONTEXTS.freeze

    ALL_CONTEXTS = CONTEXTS.map { |m| m.second }.freeze
  end
end