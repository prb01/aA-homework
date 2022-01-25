class UserMailer < ApplicationMailer
  default from: '99cats@dogaintone.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/cats'

    mail(to: @user.username, subject: "#{@user.username}, welcome to 99cats!")
  end
end
