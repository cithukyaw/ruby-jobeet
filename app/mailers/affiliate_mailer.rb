class AffiliateMailer < ActionMailer::Base
  default from: "noreply@example.com"

  def affiliate_activate_mail(affiliate)
    @affiliate  = affiliate
    @url_json   = api_url(token: @affiliate.token, format: 'json')
    @url_xml    = api_url(token: @affiliate.token, format: 'xml')
    @url_yaml   = api_url(token: @affiliate.token, format: 'yaml')
    mail(to: @affiliate.email, subject: 'Ruby Jobeet affiliate token')
  end
end
