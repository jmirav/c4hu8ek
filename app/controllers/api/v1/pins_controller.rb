class Api::V1::PinsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    render json: Pin.all.order('created_at DESC')
  end

  def create
    pin = Pin.new(pin_params)
    pin.user = current_user
    if pin.save
      render json: pin, status: 201
    else
      render json: { errors: pin.errors }, status: 422
    end
  end

  private
    def pin_params
      params.permit(:title, :image_url)
    end
end
