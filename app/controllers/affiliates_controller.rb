class AffiliatesController < ApplicationController

  # GET /affiliates/new
  def new
    @affiliate = Affiliate.new
  end

  # POST /affiliates/create
  def create
    @affiliate = Affiliate.new(affiliate_params)
    if @affiliate.save
      # Using redirect_to creates a new request
      redirect_to action: 'wait'
    else
      render 'new'
    end
  end

  # GET /affiliates/wait
  def wait
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def affiliate_params
      params.require(:affiliate).permit(:url, :email, :category_ids => [])
    end
end
