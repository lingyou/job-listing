class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :check_job_is_hidden, only: [:show, :edit, :update, :destroy]
  def index
    @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.order("wage_lower_bound DESC").paginate(page: params[:page], per_page: 5)
      when 'by_upper_bound'
        Job.published.order("wage_upper_bound DESC").paginate(page: params[:page], per_page: 5)
      else
        Job.published.recent.paginate(page: params[:page], per_page: 5)
      end
  end

  def new
    @job = Job.new
  end

  def show
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: "Create Success"
    else
      render :new
    end
  end
  def update
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, alert: "Job deleted"
  end
  private
  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end
  def check_job_is_hidden
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This job is archieved."
      redirect_to root_path
    end
  end
end
