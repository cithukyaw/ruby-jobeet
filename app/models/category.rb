class Category < ActiveRecord::Base
  has_many :jobs
  has_and_belongs_to_many :affiliates

  default_scope { order(created_at: :desc) }

  # Custom property `active_jobs` setter
  def active_jobs=(value)
    @active_jobs = value
  end

  # Custom property `active_jobs` getter
  def active_jobs
    @active_jobs
  end

  # Custom property `no_of_jobs` setter
  def no_of_jobs=(value)
    @no_of_jobs = value
  end

  # Custom property `no_of_jobs` getter
  def no_of_jobs
    @no_of_jobs
  end

  # Get all categories which have active jobs
  def self.get_with_jobs
    Category.joins(:jobs)
      .where('jobs.expires_at > ?', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      .where('jobs.is_activated = ?', 1)
      .group('categories.id')
  end
end
