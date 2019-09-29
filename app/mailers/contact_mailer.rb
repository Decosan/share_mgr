class ContactMailer < ApplicationMailer
  
  def contact_mail(user,payment)
    @user = user
    @payment = payment

    mail to: user.email, subject: "入金完了の連絡"
  end
end
