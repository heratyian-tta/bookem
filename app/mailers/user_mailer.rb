class UserMailer < ApplicationMailer
  def test(user)
    mail(to: user.email)
  end
end
