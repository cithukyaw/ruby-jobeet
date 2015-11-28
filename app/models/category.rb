class Category < ActiveRecord::Base
  has_many :jobs
  default_scope { order(created_at: :desc) }

  def active_jobs=(value)
    @active_jobs = value
  end

  def active_jobs
    @active_jobs
  end

  def no_of_jobs=(value)
    @no_of_jobs = value
  end

  def no_of_jobs
    @no_of_jobs
  end

  def self.get_with_jobs
    Category.joins(:jobs)
      .where('jobs.expires_at > ?', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      .where('jobs.is_activated = ?', 1)
      .group('categories.id')
  end
end
