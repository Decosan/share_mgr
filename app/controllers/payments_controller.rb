class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      User.where(admin: true).each do |user|
        ContactMailer.contact_mail(user, @payment).deliver
      end
      flash[:success] ="管理者にメールが送られました"
      redirect_to payments_user_path(current_user.id)
    else 
      flash[:danger] ='失敗しました'
      render 'new'
    end
  end

  def confirm
    @payment = Payment.new(payment_params)
  end

  def update
    @payment = Payment.find(params[:id])
    @payment.update_attributes(confirm: 1)
    ConfirmMailer.confirm_mail(@payment.user,@payment).deliver
    flash[:success] ="入金をConfirmしました！"
    redirect_back(fallback_location: root_path)
  end

  private

  def payment_params
    params.require(:payment).permit(:month, :amount, :confirm, :method, :user_id)
  end
end
