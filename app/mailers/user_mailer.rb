class UserMailer < ApplicationMailer

    def notify(user,url)
        @user = user
        @url  = "https://#{url}"
        mail(to: @user.email, subject: 'Your Product is Back')
      end
end
