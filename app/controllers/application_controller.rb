class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session #:exception

  respond_to :json
  
  before_filter :set_search

def set_search
	@search=Center.search(params[:q])
end

	
end
