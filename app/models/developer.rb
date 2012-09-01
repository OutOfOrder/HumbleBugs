class Developer < ActiveRecord::Base
  has_many :games, :inverse_of => :developer
  has_many :users, :inverse_of => :developer

  attr_accessible :name, :time_zone, :website
  attr_accessible :name, :time_zone, :website, :address, :contact_information, :as => :manager

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :website, :with => URI::regexp(%w(http https)), allow_blank: true

  before_save :set_null_fields

private
  def set_null_fields
    self.time_zone = nil if self.time_zone.blank?
    self.website = nil if self.website.blank?
  end
end
