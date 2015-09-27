json.array!(@posts) do |post|
  json.extract! post, :id, :title, :slug, :content, :tag_id
  json.url post_url(post, format: :json)
end
