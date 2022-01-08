class Api::HerosController < ApplicationController
  include Authenticable

  before_action :authenticable_with_token, except:[:show]
  before_action :set_hero, only: [:show, :update, :destroy]

  # GET /api/heros
  def index
    @heros = Hero.search(params[:term]).sorted_by_name
    render json: @heros
  end

  # GET /api/heros/1
  def show
    render json: @hero
  end

  # POST /api/heros
  def create
    @hero = Hero.new(hero_params)

    @hero.transaction do
        if @hero.save
          render json: @hero, status: :created, location: @hero
        else
          render json: @hero.errors, status: :unprocessable_entity
        end
    end
  end

  # PATCH/PUT /api/heros/1
  def update
    if @hero.update(hero_params)
      render json: @hero
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/heros/1
  def destroy
    @hero.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hero_params
      params.require(:hero).permit(:name)
    end
end
