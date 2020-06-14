class TestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def test_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: '私のサイトへようこそ')
  end
end
