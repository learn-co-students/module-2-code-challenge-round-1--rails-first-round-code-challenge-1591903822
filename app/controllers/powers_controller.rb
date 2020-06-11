class PowersController < ApplicationController
  before_action :find_power, only: [:show, :edit, :update]
  
  def index
    @powers = Power.all
  end

  def show
    @heroines = @power.heroines
  end

  def edit
    @heroines = Heroine.all
  end

  def update
    @power.update(power_params)

    @heroinepower = Heroinepower.new
    @heroinepower.power_id = @power.id
    byebug 
    #=> Can't access heroine_power_params[:heroine_id], says not permitted
    @heroinepower.heroine_id = heroine_power_params[:heroine_id]
    redirect_to power_path(@power)
  end

  private

  def find_power
    @power = Power.find(params[:id])
  end


  def power_params
    params.require(:power).permit(:name, :description)
  end

  def heroine_power_params
    params.require(:heroinepower).permit(:heroine_id)
  end

end
