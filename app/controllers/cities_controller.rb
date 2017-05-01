class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :require_is_admin


def index
	@cities = City.all
  @cities = City.paginate(:page => params[:page], :per_page => 10)
end

def show
end


def new
	@city = City.new
end

def edit
end


def create
	@city = City.new(city_params)

	respond_to do |format|
	  if @city.save
  	  format.html { redirect_to @city, notice: 'city was successfully created.' }
    	format.json { render :show, status: :created, location: @city }
  	else
    	format.html { render :new }
    	format.json { render json: @city.errors, status: :unprocessable_entity }
  	end
	end
end


def update
	respond_to do |format|
  	if @city.update(city_params)
    	format.html { redirect_to @city, notice: 'city was successfully updated.' }
    	format.json { render :show, status: :ok, location: @city }
  	else
    	format.html { render :edit }
    	format.json { render json: @city.errors, status: :unprocessable_entity }
  	end
	end
end


def destroy
	@city.destroy
	respond_to do |format|
  	format.html { redirect_to categories_url, notice: 'city was successfully destroyed.' }
  	format.json { head :no_content }
	end
end
end
 private

 def set_city
   @city = City.find(params[:id])
  end


def city_params
  params.require(:city).permit(:name)
end
