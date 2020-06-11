class HeroinesController < ApplicationController
  before_action :find_heroine, only: [:show]
  
  def index
    @heroines = Heroine.all
  end

  def show
    @powers = @heroine.powers
  end

  def new
    @powers = Power.all
    @heroine = Heroine.new
  end

  def create
    heroine = Heroine.create(heroine_params)
    
    # Didn't if needed to add validation here as well...
    heroinepower = Heroinepower.new()
    heroinepower.power_id = heroine_power_params[:power_id]
    heroinepower.heroine_id = heroine.id
    heroinepower.save

    if heroine.valid?
      redirect_to heroine_path(heroine)
    else
      flash[:heroine_errors] = heroine.errors.full_messages
      redirect_to new_heroine_path 
    end
    
  end

  private

  def find_heroine
    @heroine = Heroine.find(params[:id])
  end

  def heroine_params
    params.require(:heroine).permit(:name, :super_name)
  end

  def heroine_power_params
    params.require(:heroinepower).permit(:power_id)
  end
end
