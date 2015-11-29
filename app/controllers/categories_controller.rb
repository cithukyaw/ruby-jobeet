class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /category/slug
  # GET /category/slug.json
  def show
    # @jobs = Job.joins(:category).where('categories.slug = ?', params[:slug])
    # @jobs = Job.joins(:category).where(categories: { slug: params[:slug] })
    @jobs = Job.joins(:category)
      .where(categories: { id: @category.id })
      .page(params[:page]).per(Rails.application.config.max_jobs_on_category) # Use `kaminari`
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by_slug(params[:slug])
      # @category = Category.find_by slug: params[:slug]
      # @category = Category.find_by! slug: params[:slug]
      # @category = Category.where(slug: params[:slug]).take
      # @category = Category.where('slug' => params[:slug]).take
      # @category = Category.where('slug = ?', params[:slug]).take
      # @category = Category.where('slug = :slug', { slug: params[:slug] }).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :slug)
    end
end
