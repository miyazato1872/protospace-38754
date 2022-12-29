class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.includes(:user)   #Prototype.allでもできるが、N+1問題の兼ね合いでincludes(:user)を使用する
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user) 
  end

  def edit
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit([:image, :title, :catch_copy,:concept]).merge(user_id: current_user.id) ##ここ、current_user.idが必要か確認
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end

