ActiveAdmin.register Category do

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

  permit_params :name, :slug

  config.sort_order = 'name_asc'

  filter :name

  index do
    column :name
    column :slug
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :slug
      row :created_at
    end
  end
end
