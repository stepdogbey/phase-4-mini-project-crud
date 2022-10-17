class SpicesController < ApplicationController

   rescue_from ActiveRecord::RecordNotFound, with: :no_spice_error_response
   wrap_parameters format: {}

   def index
    spices = Spice.all 
    render json: spices
   end

   def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
   end
   
   def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
   end

   def destroy
    spice = find_spice
    spice.destroy 
    head :no_content
   end



   private
   def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
   end

   def find_spice
    Spice.find(params[:id])
   end

   def no_spice_error_response
    render json: {error: "Spice not found"}, status: :not_found
   end
end
