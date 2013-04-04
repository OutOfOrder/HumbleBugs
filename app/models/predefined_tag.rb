class PredefinedTag < ActiveRecord::Base
  def self.with_context(*contexts)
    where(:context => contexts.map(&:to_s))
  end

  CONTEXTS = [
      ['Platforms', :platforms],
  ]

  validates_presence_of :name, :context
  validates_uniqueness_of :name, :scope => [ :context ]
  validates_inclusion_of :context, :in => -> pt { CONTEXTS.map { |m| m.second.to_s } }, :message => "context %{value} is not a valid context"
end
