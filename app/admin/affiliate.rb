ActiveAdmin.register Affiliate do

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

  permit_params :url, :email

  index do
    column :url
    column :email
    column :created_at
    actions defaults: false do |affiliate|
      if affiliate.is_active?
        link_to 'Deactivate', deactivate_admin_affiliate_path(affiliate)
      else
        link_to 'Activate', activate_admin_affiliate_path(affiliate)
      end
    end
  end

  member_action :activate, method: :get do
    @affiliate = Affiliate.find(params[:id])
    if @affiliate.activate
      AffiliateMailer.affiliate_activate_mail(@affiliate).deliver
    end
    redirect_to :back, notice: "Activated!"
  end

  member_action :deactivate, method: :get do
    Affiliate.find(params[:id]).deactivate
    redirect_to :back, notice: "Deactivated!"
  end
end
