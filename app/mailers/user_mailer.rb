class UserMailer < ApplicationMailer
  def welcome_email(email)
    mail(to: email, subject: '欢迎使用邮件系统！')
  end
end
