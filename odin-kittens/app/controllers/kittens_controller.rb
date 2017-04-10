class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to kitten_path(@kitten)
    else
      flash[:danger] = "Somethings wrong with your form"
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])   
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = "success editing!"
      redirect_to root_url
    else 
      flash[:danger] = "Somethings wrong with your form"
      render 'edit'
    end

  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def destroy
    Kitten.find(params[:id]).destroy    
    redirect_to root_url
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :cuteness, :softness)
  end
end
