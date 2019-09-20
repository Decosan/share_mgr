class PersonnelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_personnel, only:[:edit, :update]

  def new
    @personnel = Personnel.new
  end

  def create
    @personnel = Personnel.new(personnel_params)
    @personnel.user_id = current_user.id
    if @personnel.save
      flash[:success] ='個人情報ページを作成しました'
      redirect_to user_path(current_user.id)
    else
      flash[:danger] ='作成できませんでした'
      render 'new'
    end  
  end

  def edit
  end

  def update
    if @personnel.update(personnel_params)
      flash[:success] ='個人情報ページを編集しました'
      redirect_to user_path(current_user.id)
    else
      flash[:danger] ='編集できませんでした'
      render 'edit'
    end  
  end

  private
  
  def personnel_params
    params.require(:personnel).permit(:last_name, :first_name, :gender, :room, :birth_date, :in_date, :out_plan_date)
  end

  def set_personnel
    @personnel = current_user.personnel
  end
end
