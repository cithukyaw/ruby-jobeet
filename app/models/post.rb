class Post < ActiveRecord::Base
    attribute_accessible :title, :slug, :content, :tag_id
    belongs_to :tag
end
