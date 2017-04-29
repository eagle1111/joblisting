class Account::JobsController < ApplicationController
  before_action :authenticate_user!

def index
  @jobs = current_user.participated_jobs
    @jobs = Job.paginate(:page => params[:page], :per_page => 10)
end
end
