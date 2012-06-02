class PredefinedTag < ActiveRecord::Base

  CONTEXTS = [
      ['Platforms', :platforms],
  ]

  validates_presence_of :name, :context
  validates_inclusion_of :context, :in => -> pt { CONTEXTS.map { |m| m.second.to_s } }, :message => "context %{value} is not a valid context"
end
