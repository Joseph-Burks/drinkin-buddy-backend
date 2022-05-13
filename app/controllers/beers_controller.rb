class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :update, :destroy]

  # GET /beers
  def index
    @beers = Beer.all
    render json: @beers, include: [:brewery]
  end

  #GET /beers-20
  def first_twenty
    @beers = Beer.first(20)
    render json: @beers
  end

  # GET /beers/1
  def show
    render json: @beer, include: [:brewery, :reviews]
  end

  # POST /beers
  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      render json: @beer, include: [:brewery, :reviews], status: :created, location: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beers/1
  def update
    if @beer.update(beer_params)
      render json: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beers/1
  def destroy
    @beer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beer_params
      params.require(:beer).permit(:name, :brewery_id, :style, :description, :alcohol_content, :bitterness)
    end
end
