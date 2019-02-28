class UserMailer < ApplicationMailer

    def notify(user, msg,url)
        @user = user
        @url  = "https://#{url}"
        @message=msg
        mail(to: @user.email, subject: 'Your Product is Back')
      end
end
