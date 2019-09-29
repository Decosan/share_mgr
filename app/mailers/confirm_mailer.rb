class ConfirmMailer < ApplicationMailer
  
  def confirm_mail(user,payment)
    @user = user
    @payment = payment

    mail to: user.email, subject: "ご入金を確認致しました"
  end
end
