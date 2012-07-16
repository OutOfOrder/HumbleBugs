class Feedback
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  validates_presence_of :message

  attr_accessor :message
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end