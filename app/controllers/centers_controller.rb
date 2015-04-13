class CentersController < ApplicationController
	respond_to :json
	def index
#=begin
		if params[:q].present?
			

			@search = Center.search(params[:q]) 
			@search.sorts = 'zip_code asc' if @search.sorts.empty?
			
			@centers = @search.result(distinct: true).paginate(page: params[:page], per_page: 6)
			@total = @centers.count
			@page = params[:page]

			respond_to do |format|
				format.html 
				format.json {render json: @centers} #{render :index, status: :created, location: @centers}#
			end
			
		else
			@centers = []
			@total = 0
			respond_to do |format|
				format.html {render :index}
				format.json {render json: @centers}
			end
		end
#=end
	end

	def show
		@center = Center.find(params[:id])
		
		respond_to do |format|
			format.html {render :show}
			format.json {render :show, status: :created, location: @center}
		end
	end

	private

	def permit_all
		params.permit!
	end
end
