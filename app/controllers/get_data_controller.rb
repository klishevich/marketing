class GetDataController < ApplicationController
  def index
    @data=GetDatum.all
  end

  def new
    @data = GetDatum.new
  end

  def create
    @data = GetDatum.new(data_params)
    if @data.save
      redirect_to @data
    else
      render 'new'
    end
  end

  def show
    @data = GetDatum.find(params[:id])
  end

  # def edit
  # 	@message=Message.find(params[:id])
  # end

  # def update
  #   @message = Demand.find(params[:id])
  #   if @demand.update_attributes(demand_params)
  #     flash[:success] = t(:ok)
  #     redirect_to @demand
  #   else
  #     render 'edit'
  #   end
  # end	

  private

  def data_params
    params.require(:get_datum).permit(:url, :data)
  end  	
end
