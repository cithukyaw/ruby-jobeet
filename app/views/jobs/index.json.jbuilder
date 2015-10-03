json.array!(@jobs) do |job|
  json.extract! job, :id, :type, :company, :logo, :url, :position, :location, :description, :how_to_apply, :token, :is_public, :is_activated, :email, :expires_at, :category_id
  json.url job_url(job, format: :json)
end
