class InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :update]

  # GET /interests
  def index
    @interests = Interest.all

    render json: @interests
  end

  # GET /interests/1
  def show
    render json: @interest
  end

  # POST /interests
  def create
    @interest = Interest.new(beer_id: interest_params[:beer_id], user_id: current_user.id)

    if @interest.save
      @user = current_user
      render json: {
          id: @user.id,
          username: @user.username,
          reviews: @user.get_reviews_with_beer,
          interests: @user.interested
        }
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interests/1
  def update
    if @interest.update(interest_params)
      render json: @interest
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interests/1
  def destroy
  interest = Interest.find_by(beer_id: interest_params[:beer_id], user_id: current_user.id)
  interest.destroy
  @user = current_user
  render json: {
          id: @user.id,
          username: @user.username,
          reviews: @user.get_reviews_with_beer,
          interests: @user.interested
        }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interest_params
      params.require(:interest).permit(:beer_id, :user_id)
    end
end
