class RoutinesController < ApplicationController
  before_action :set_routine, only:[:show]


  def index
    @routines = Routine.all.page(params[:page])
  end

  def show
    @assignments = Assignment.all.order('start_time ASC')
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end
end
