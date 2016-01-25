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

  # Get all active jobs
  # @param object  options
  # @param integer options[:category]   The category id
  # @param integet options[:affiliate]  The affiliate id
  # @param integer options[:max]        Maximum number of jobs to be fetched
  # @param integer options[:count]      true for for count query
  # @return collection|integer
  def self.get_active_jobs(options = {})
    options = { category: nil, affiliate: nil, max: nil, count: nil }.merge(options)

    query = self
      .where('jobs.expires_at > ?', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      .where('jobs.is_activated = ?', 1)
      .order('jobs.created_at DESC')

    if options[:category].present?
      query = query.where('jobs.category_id = ?', options[:category])
    end

    if options[:affiliate].present?
      query = query.joins('LEFT JOIN `categories` ON categories.id = jobs.category_id')
        .joins('LEFT JOIN `affiliates_categories` ON affiliates_categories.category_id = categories.id')
        .where('affiliates_categories.affiliate_id = ?', options[:affiliate])
    end

    if options[:max].present?
      query = query.take(options[:max])
    end

    if options[:count].present?
      return query.count
    end

    return query
  end

  # Count all active jobs
  # @param object  options
  # @param integer options[:category]   The category id
  # @param integet options[:affiliate]  The affiliate id
  # @param integer options[:max]        Maximum number of jobs to be fetched
  # @param integer options[:count]      true for for count query
  # @return integer
  def self.count_active_jobs(options = {})
    options = { category: nil, affiliate: nil, max: nil, count: nil }.merge(options)
    options[:count] = true
    self.get_active_jobs(options)
  end

  # Convert active record list to hash
  def self.as_hash(active_jobs)
    data = Hash.new
    active_jobs.each do |job|
      # non_friendly_url = job_url({ id: job.id })
      friendly_url = Rails.application.routes.url_helpers.job_url(job, :host => Rails.application.config.action_mailer.default_url_options[:host])
      data[friendly_url] = {
        category:     job.category.name,
        type:         Job::EMPLOYMENT_TYPES.key(job.employment_type),
        company:      job.company,
        logo:         job.logo_url,
        url:          job.url,
        position:     job.position,
        location:     job.location,
        description:  job.description,
        how_to_apply: job.how_to_apply,
        expires_at:   job.expires_at.strftime('%Y-%m-%d')
      }
    end
    return data
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
