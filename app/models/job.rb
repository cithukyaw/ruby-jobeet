require 'valid_email'

class Job < ActiveRecord::Base
  belongs_to :category
  validates :category, presence: true
  validates :employment_type, presence: true
  validates :company, presence: true
  validates :position, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :how_to_apply, presence: true, length: { minimum: 50 }
  validates :email, presence: true, email: true

  before_create :set_expires_at_value, :set_token_value

  def employment_types
    [
      ['Full Time', 'full-time'],
      ['Part Time', 'part-time'],
      ['Freelance', 'freelance'],
      ['Internship', 'internship']
    ]
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
