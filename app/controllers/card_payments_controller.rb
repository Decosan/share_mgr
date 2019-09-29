class CardPaymentsController < ApplicationController

  def new
    @card_payment = CardPayment.new
  end

  def create
    @card_payment = current_user.card_payments.build(card_payment_params)
    if @card_payment.save
      flash[:success] ='カード支払いアイテムが追加されました'
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
    params.require(:card_payment).permit(:month, :amount, :confirm, :user_id)
  end
end
