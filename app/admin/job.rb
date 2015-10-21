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
    column :url do |j|
      link_to j.url, j.url
    end
    column :employment_type do |j|
      Job::EMPLOYMENT_TYPES.key(j.employment_type)
    end
    column :location
    column :email
    column :expires_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :employment_type, as: :select, collection: Job::EMPLOYMENT_TYPES
      f.input :position
      f.input :company
      f.input :logo, as: :file
      f.input :url
      f.input :location
      f.input :description
      f.input :how_to_apply
      f.input :email
      f.input :expires_at,
        as: :datepicker,
        datepicker_options: { date_format: "yy-mm-dd", min_date: Time.to_s + "+1D" },
        input_html: { :value => f.object.expires_at ? f.object.expires_at.strftime('%Y-%m-%d') : (Date.today+7).to_s } # default +7 days
      f.input :is_public
      f.input :is_activated
    end
    actions
  end

  show do
    attributes_table do
      row :position
      row :category
      row :employment_type do |j|
        Job::EMPLOYMENT_TYPES.key(j.employment_type)
      end
      row :company
      row('Logo') { |j| link_to j.logo, j.logo_url, { target: '_blank' } }
      row :url do |j|
        link_to j.url, j.url
      end
      row :location
      row :description do |j|
        simple_format j.description # same as simple_format(j.description)
      end
      row('How to apply?') { |j| simple_format j.how_to_apply }
      row :email
      row("Published?") { |j| j.is_public ? 'Yes' : 'No' }
      row("Activated?") { |j| j.is_activated ? 'Yes' : 'No' }
      row("Posted on") { |j| j.created_at.strftime('%Y-%m-%d') }
      row("Expires on") { |j| j.expires_at.strftime('%Y-%m-%d') }
    end
  end
end
