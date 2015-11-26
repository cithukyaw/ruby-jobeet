require 'carrierwave/orm/activerecord'
require 'valid_email'

class Job < ActiveRecord::Base
  belongs_to :category
  mount_uploader :logo, JobLogoUploader

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  ## validation ###

  validates :category, presence: true
  validates :employment_type, presence: true
  validates :company, presence: true
  validates :position, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :how_to_apply, presence: true, length: { minimum: 25 }
  validates :email, presence: true, email: true

  ## active record callbacks ###

  before_create :set_expires_at_value, :set_token_value

  ## constants ##

  EMPLOYMENT_TYPES = {
    'Full Time'   => 'full-time',
    'Part Time'   => 'part-time',
    'Freelance'   => 'freelance',
    'Internship'  => 'internship'
  }

  ## methods ##

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:company, :location, :id, :position]
    ]
  end

  def self.get_active_jobs(options = {})
    options = { category: nil, max: nil }.merge(options)

    query = self
      .where('jobs.expires_at > ?', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      .where('jobs.is_activated = ?', 1)

    if options[:category].present?
      query = query.where('jobs.category_id = ?', options[:category])
    end

    if options[:max].present?
      query = query.take(options[:max])
    end

    return query
  end

  protected
    def set_expires_at_value
      if self.expires_at.nil?
        self.expires_at = Time.new + (30 * 24 * 60 * 60)
      end
    end

    def set_token_value
      if self.token.nil?
        value = self.email + rand(11111..99999).to_s
        self.token = Digest::SHA1.hexdigest value
      end
    end
end
