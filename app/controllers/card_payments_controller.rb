class CardPaymentsController < ApplicationController

  def new
    @card_payment = CardPayment.new
  end

  def create
    @card_payment = current_user.card_payments.build(card_payment_params)
    if @card_payment.save
      flash[:success] ='クレジット決算が完了しました'
      redirect_to purchase_index_path
    else
      flash[:danger] ="失敗しました"
      render 'purchase/index'
    end
  end

  def destroy
  end

  private

  def card_payment_params
    params.require(:card_payment).permit(:amount, :confirm, :user_id)
  end
end
