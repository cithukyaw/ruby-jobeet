class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :slug, presence: true, format: { with: /\A[a-zA-Z-]+\z/, message: "Only letters allowed" }
  validates :content, presence: true, length: { minimum: 50 }
  validates :tag, presence: true
  belongs_to :tag
end
