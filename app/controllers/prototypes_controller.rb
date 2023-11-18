class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new, :create]
  before_action :move_to_index, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render 'edit'
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user_id = current_user.id
    if @prototype.save
      redirect_to root_path
    else
      puts "Form Data:"
      puts prototype_params.inspect
      @prototypes = Prototype.includes(:user).all
      render 'index'
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def check_user
    # ログインユーザーと編集対象のプロトタイプのユーザーが一致しない場合、トップページにリダイレクト
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end



end
