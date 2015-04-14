class HealthController < ApplicationController

	def index

		if params[:health].present?
			@health = params[:health]
			respond_to do |format|
				format.html
			end
		else
			@health = []
			respond_to do |format|
				format.html {render :index}
				#format.json {render json: @centers}
			end
		end
	end



	private

	def permit_all
		params.permit!
	end
end
