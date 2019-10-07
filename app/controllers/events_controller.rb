class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only:[:show, :edit, :update, :destroy]
  before_action :delete_picture, only:[:update]
  before_action :correct_user, only:[:edit, :update, :destroy]
  after_action :read, only:[:show]


  def index
    @users = User.all
    if params[:event] && params[:event][:search]
      if params[:event][:title] == "" && params[:event][:label_ids] == ""
        redirect_to events_path
      elsif params[:event][:title].present?
        @events = Event.where("title LIKE ?", "%#{ params[:event][:title] }%").page(params[:page])
      elsif params[:event][:label_ids].present?
        @events = Event.joins(:event_labels).where('event_labels.label_id = ?', params[:event][:label_ids]).page(params[:page])
      end
    else
      if params[:start_date] == "true"
        @events = Event.order(start_date: :ASC).page(params[:page])
      elsif params[:my_event] == "true"
        @events = current_user.events.order(start_date: :ASC).page(params[:page])
      else
        @events = Event.order('created_at DESC').page(params[:page])
      end
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      unless @event.user_events.find_by(user_id: current_user.id).present?
        current_user.user_events.create(event_id: @event.id, accesstime: Time.current)
      end
      flash[:success] ='新規イベントを作成しました'
      redirect_to events_path
    else
      flash[:danger] ='作成できませんでした'
      render 'new'
    end  
  end

  def show
    @comments = @event.comments
    @comment = @event.comments.build
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

  def read
    unless current_user.user_events.pluck(:event_id).include?(@event.id)
      current_user.user_events.create(event_id: @event.id, accesstime: Time.current)
    else
      @event.user_events.find_by(user_id: current_user.id).update(accesstime: Time.current)
    end  
  end


  def delete_picture
    if images = params[:event][:destroy_images]
      images.each do |img| 
        @event.images.find(img).destroy
      end
      redirect_back(fallback_location: root_path)
    else
    end
  end

  def event_params
    params.require(:event).permit(:title,:content,:start_date,:user_id, images: [], label_ids: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def correct_user
    unless @event.user.id == current_user.id
      redirect_to root_path
    end
  end
end
