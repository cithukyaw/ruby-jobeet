ActiveAdmin.register Job do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  permit_params :employment_type, :company, :logo, :url, :position, :location, :description, :how_to_apply, :token, :is_public, :is_activated, :email, :expires_at, :category_id

  index do
    column :position
    column :company
    column :url
    column :employment_type
    column :location
    column :email
    column :expires_at
    actions
  end

end
