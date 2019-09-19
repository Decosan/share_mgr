class UsersController < ApplicationController
  before_action :set_user, only:[:show,:edit,:update]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ='ユーザー登録に成功しました'
      redirect_to user_path(@user)
    else
      flash[:danger] ='登録できませんでした'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:avatar]
      @user.update params.require(:user).permit(:avatar)
      flash[:success] ='プロファイル画像を編集しました'
      redirect_back(fallback_location: root_path)   
    elsif params[:user][:name]
      @user.update(user_params)
      flash[:success] ='ユーザー情報の編集に成功しました'
      redirect_to user_path(@user)
    else
      flash[:danger] ='編集できませんでした'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
