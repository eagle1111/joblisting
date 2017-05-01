class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :validate_search_key, only: [:search]
  def show
    @job=Job.find(params[:id])
    if @job.is_hidden
          flash[:warning] = "This Job already archived"
          redirect_to root_path
        end
  end
  def index
    @jobs = case params[:order]
         when 'by_lower_bound'
           Job.published.order('wage_lower_bound DESC')
         when 'by_upper_bound'
           Job.published.order('wage_upper_bound DESC')
         else
           Job.published.recent
         end
    @jobs = Job.paginate(:page => params[:page], :per_page => 10)
  end
  def new
    @job=Job.new
  end
  def create
    @job=Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end
  def edit
      @job=Job.find(params[:id])
  end
  def update
      @job=Job.find(params[:id])
      if @job.update(job_params)
        redirect_to jobs_path
      else
        render :edit
      end
  end
  def destroy
    @job=Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end
  def join
 @job = Job.find(params[:id])

  if !current_user.is_member_of?(@job)
    current_user.join!(@job)
    flash[:notice] = "收藏成功！"

  end

  redirect_to job_path(@job)
end

def quit
  @job = Job.find(params[:id])

  if current_user.is_member_of?(@job)
    current_user.quit!(@job)
    flash[:alert] = "取消收藏！"

  end

  redirect_to job_path(@job)
end
  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end
  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end



private
def job_params
  params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_lower_bound,:contact_email,:is_hidden)
end
end
