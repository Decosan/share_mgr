class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      User.where(admin: true).each do |user|
        ContactMailer.contact_mail(User).deliver
      end
      flash[:success] ="管理者にメールが送られました"
      redirect_to payments_user_path(current_user.id)
    else 
      flash[:danger] ='失敗しました'
      render 'new'
    end
  end

  def confirm
  end

  private

  def payment_params
    params.require(:payment).permit(:month, :confirm, :user_id)
  end
end
