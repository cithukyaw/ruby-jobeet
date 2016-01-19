class ApiController < ApplicationController

  # GET /api/:token/jobs.:format
  # @param string token
  # @param string format json|xml|yaml
  def list
    @affiliate = Affiliate.get_by_token(params[:token])
    if @affiliate.nil?
      raise ArgumentError, 'This affiliate account does not exist!'
    end

    @jobs = Job.as_hash(Job.get_active_jobs({ affiliate: @affiliate.id }))

    if params[:format] == 'json'
      render json: @jobs
    elsif params[:format] == 'xml'
      render 'jobs.xml.erb', layout: false, content_type: 'application/xml'
    else
      render 'jobs.yaml.erb', layout: false, content_type: 'text/yaml'
    end
  end
end
