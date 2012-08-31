class Developer < ActiveRecord::Base
  attr_accessible :address, :name, :time_zone, :contact_information, :website

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :website, :with => URI::regexp(%w(http https)), allow_nil: true

  before_save :set_null_fields

private
  def set_null_fields
    self.time_zone = nil if self.time_zone.blank?
    self.website = nil if self.website.blank?
  end
end
