class Api::RentalsController < Api::ApplicationController
  before_action :check_api_key_authorized
  before_action :set_api_user
  before_action :set_rental, only: [:show, :destroy]

  # GET /api/rentals
  def index
    @rentals = Rental.where(owner: @api_user)
  
    # render json: @rentals, each_serializer: RentalsSerializer
    render json: @rentals, class: { Rental: RentalSerializer }
  end

  # GET /api/rentals/1
  def show
    render jsonapi: @rental, class: { Rental: RentalSerializer }
  end

  # POST /api/rentals
  def create
    @rental = Rental.new(rental_params.except(:api_key).merge(owner: @api_user))
    
    if @rental.save
      render jsonapi: @rental, class: { Rental: RentalSerializer }
    else
      render json: { status: 422, message: @rental.errors.full_messages.first.to_s }, status: :unprocessable_entity
    end
  end

  # DELETE /api/rentals/1
  def destroy
    if @rental.destroy!
      render json: { status: 200, message: 'Rental successfully deleted.' }, status: 200
    else
      render json: { status: 422, message: 'Failed to delete rental.' }, status: 422
    end
  end

  private

  def rental_params
    params.permit(
      :id, :api_key, :title, :city, :location,
      :category, :image, :bedrooms, :description, :street_address
    )
  end

  def check_api_key_authorized
    api_key_exists = User.find_by(api_key: rental_params[:api_key])
    if !api_key_exists.present?
      render json: { status: 422, message: "API key not authorized" }, status: 422
    end
  end

  def set_api_user
    @api_user = User.find_by(api_key: rental_params[:api_key])
  end

  def set_rental
    @rental = Rental.find_by(id: rental_params[:id], owner: @api_user)
    if !@rental.present?
      render json: { status: 422, message: "Rental #{rental_params[:id]} not found for api_user" }, status: 422
    end
  end
end