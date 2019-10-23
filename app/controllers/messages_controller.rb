class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  before_action :update_last_accesstime, only:[:index]
  
  def index
    @messages = @conversation.messages

  if @messages.length > 10
    @over_ten = true
    @messages = Message.where(id: @messages[-10..-1].pluck(:id))
  end

  if params[:m]
    @over_ten = false
    @messages = @conversation.messages
  end

  if @messages.last
    @messages.where.not(user_id: current_user.id).update_all(read: true)
  end

  @messages = @messages.order(:created_at)
  @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash.now[:error] = @message.errors.full_messages
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def update_last_accesstime
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.last_accesstime = @conversation.accesstime
    @conversation.accesstime = DateTime.now
    @conversation.save!
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
