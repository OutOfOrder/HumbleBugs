class PredefinedTag < ActiveRecord::Base
  def self.with_context(*contexts)
    where(:context => contexts.map(&:to_s))
  end

  validates_presence_of :name, :context
  validates_uniqueness_of :name, :scope => [ :context ]
  validates_inclusion_of :context, :in => Types::PredefinedTag::ALL_CONTEXTS.map(&:to_s), :message => "context %{value} is not a valid context"
end
