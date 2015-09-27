class Tag < ActiveRecord::Base
    attribute_accessible :title, :slug, :description
    has_many :posts
end
