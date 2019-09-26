class ContactMailer < ApplicationMailer
  def contact_mail(user)
    @user = user

    mail to: "junx0401@gmail.com", subject: "お問い合わせの確認メール"
  end
end
