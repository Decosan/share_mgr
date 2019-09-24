class AssignmentsController < ApplicationController
  before_action :set_assignment, only:[:edit, :update, :destroy]


  def new
    @assignment = Assignment.new
    @assignment.routine_id = params[:routine_id]
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      flash[:success] ="タスクをアサインしました"
      redirect_to routine_path(@assignment.routine_id)
    else
      flash[:danger] ="アサイン出来ませんでした"
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @assignment.destroy
    flash[:danger] ="アサインを取り消しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:title, :content, :start_time, :user_id, :routine_id)
  end
end
