class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only:[:show, :edit, :update, :destroy]


  def index
    @events = Event.all.page(params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] ='新規イベントを作成しました'
      redirect_to events_path
    else
      flash[:danger] ='作成できませんでした'
      render 'new'
    end  
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] ='イベントを編集しました'
      redirect_to event_path(@event.id)
    else
      flash[:danger] ='編集できませんでした'
      render 'edit'
    end  
  end

  def destroy
    @event.destroy
    flash[:danger] ='イベントを削除しました'
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title,:content,:start_date,:end_date,:user_id)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
