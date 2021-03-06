class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @categories = Category.get_with_jobs
    @categories.each do |category|
      category.active_jobs = Job.get_active_jobs({ category: category.id, max: Rails.application.config.max_jobs_on_homepage })
      category.no_of_jobs = Job.count_active_jobs({ category: category.id })
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /search
  def search
    # @query = params[:query].gsub!(/[^a-zA-Z0-9 ]/, '');
    @query = params[:query];
    keywords = @query.split(' ');

    qb = Job.order('created_at DESC')
      .where('expires_at > ?', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      .where('is_activated = ?', 1)

    keywords.each do |keyword|
      value = '%' + keyword + '%'
      qb = qb.where('company LIKE ? OR position LIKE ? OR location LIKE ?', value, value, value)
    end

    @jobs = qb.page(params[:page]).per(Rails.application.config.max_jobs_on_category) # Use `kaminari`

    render :search
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:employment_type, :company, :logo, :url, :position, :location, :description, :how_to_apply, :token, :is_public, :is_activated, :email, :expires_at, :category_id)
    end
end
