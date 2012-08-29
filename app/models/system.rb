class System < ActiveRecord::Base
  belongs_to :user, :inverse_of => :systems
  has_many :test_results, :inverse_of => :system

  acts_as_taggable_on :platforms

  attr_accessible :name, :description, :graphics_card, :graphics_driver, :operating_system, :processor, :platform_list

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, :scope => [ :user_id ]
  validates_presence_of :platform_list
end
