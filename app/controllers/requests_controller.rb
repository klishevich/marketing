class RequestsController < ApplicationController
  def index
  	@requests = Request.all
  end

  def new
  	@request = Request.new
  end

  def create
  	# @request = Request.new(request_params)
    Request.parse
    redirect_to requests_path
  	# if @request.save
  	# 	redirect_to @request
  	# else
  	# 	render new
  	# end
  end

  def show
  	@request = Request.find(params[:id])
  end

  private

  def request_params
    params.require(:request).permit(:url, :result)
  end    
end
