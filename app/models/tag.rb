class Tag < ActiveRecord::Base
  has_many :posts

  ## validation ##

  validates :title, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z-]+\z/, message: "Only letters allowed" }
end
