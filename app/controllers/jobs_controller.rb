class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]
  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.publicjobs.order('wage_lower_bound DESC')
    when 'by_upper_bound'
      Job.publicjobs.order('wage_uppper_bound DESC')
    else
      Job.publicjobs.recent
    end
  end
  def new
    @job = Job.new
  end
  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: "add success"
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:notice] = "Update success"
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: "Job deleted"
  end


  private
  def job_params
    params.require(:job).permit(:title, :description,:wage_lower_bound, :wage_uppper_bound, :contact_email)
  end

end
