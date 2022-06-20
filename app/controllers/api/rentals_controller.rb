class Api::RentalsController < Api::ApplicationController
  # before_action :set_rental, only: [:show, :destroy]
  # TODO: Implement once api check implemented.
  # before_action :check_api_key_authorized

  # GET /api/rentals
  def index
    @rentals = Rental.where(owner: api_user)
  
    render json: @rentals, each_serializer: RentalsSerializer
  end

  # GET /api/rentals/1
  def show
    render json: @rental
  end

  # POST /api/rentals
  def create
    @rental = Rental.new(rental_params)

    render json: @rental
  rescue ActiveRecord::RecordInvalid => exception
    send_error(exception.message.to_s, 422)
  end

  # DELETE /api/rentals/1
  def destroy
    if @rental.destroy!
      render json: { status: 422, message: 'Rental successfully deleted.' }, status: 200
    else
      render json: { status: 422, message: 'Failed to delete rental.' }, status: 422
    end
  end

  private

  # Show and delete, id
  def rental_params
    params.permit(:rental_id, :api_key, :title, :city, :location, :category, :image, :bedrooms, :description)
  end

  # TODO: Add request test once model implemented.
  def check_api_key_authorized
    api_key_exists = ApiKey.find_by(key: rental_params[:api_key])
    if !api_key_exists.present?
      render json: { status: 422, message: "API key not authorized" }, status: 422
    end
  end

  def set_rental
    @rental = Rental.find(rental_params[:rental_id])
  end
end