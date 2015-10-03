require 'valid_email'

class Job < ActiveRecord::Base
  belongs_to :category
  validates :category, presence: true
  validates :type, presence: true
  validates :company, presence: true
  validates :position, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :how_to_apply, presence: true, length: { minimum: 50 }
  validates :email, presence: true, email: true
end
