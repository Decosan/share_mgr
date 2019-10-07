class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy, :payments]
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :return_personnel_new

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
      @user.update params.require(:user).permit(:name,:email)
      flash[:success] ='ユーザー情報の編集に成功しました'
      redirect_to user_path(current_user.id)
    elsif params[:user][:admin] == 'true'
      @user.update_attribute(:admin, "true")
      redirect_back(fallback_location: root_path)
    elsif params[:user][:no_admin] == 'true'
      @user.update_attribute(:admin, "false")
      redirect_back(fallback_location: root_path)     
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

  def payments
    @personnel = @user.personnel
    if current_user.admin.present?
      @payments = Payment.all.order('created_at DESC').page(params[:page])
    else
      @payments = current_user.payments.order('created_at DESC').page(params[:page])
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
