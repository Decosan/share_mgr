class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    if @user.id == current_user.id
      @personnel = @user.personnel
    else  
      @events = Event.where(user_id: @user.id).order('created_at DESC').page(params[:page])
    end
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
      redirect_to user_path(current_user.id)
    else
      flash[:danger] ='編集できませんでした'
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] ='ユーザーを削除しました'
    redirect_to new_user_session_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
