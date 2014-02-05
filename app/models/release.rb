class Release < ActiveRecord::Base
  belongs_to :game, :inverse_of => :releases, :touch => true
  belongs_to :owner, :class_name => 'User'
  has_many :reported_issues, :class_name => 'Issue', :inverse_of => :reported_against
  has_many :fixed_issues, :class_name => 'Issue', :inverse_of => :fixed_in
  has_many :test_results, :inverse_of => :release, :dependent => :destroy

  acts_as_taggable_on :platforms

  STATUSES = [
      ['Active', :active],
      ['Obsolete', :obsolete],
      ['Retired', :retired]
  ]

  validate :valid_checksum_length
  validates_format_of :checksum, allow_blank: true, with: /^[a-fA-F0-9]+$/, message: 'contains invalid MD5 or SHA1 characters'
  validates_inclusion_of :status, :in => STATUSES.map { |m| m.second.to_s }, :message => "%{value} is not a valid status"
  validates_presence_of :game_id, :owner_id, :version, :url, :status

  before_save :fixup_url

  def to_param
    "#{id}-#{game.name.parameterize}-#{version.parameterize}"
  end
private
  def valid_checksum_length
    length_ok =  checksum.blank? || checksum.length == 32 || checksum.length == 40
    errors.add(:checksum, "length is not a valid MD5 of SHA1") unless length_ok
  end

  def fixup_url
    m = /^https:\/\/www\.dropbox\.com\/(.+?)(\?dl=1)?$/.match(self.url)
    if m
      self.url = "https://dl.dropboxusercontent.com/#{m[1]}?dl=1"
    end
  end
end
