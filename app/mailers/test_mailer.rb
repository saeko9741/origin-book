class TestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def test_email
    @user = params[:user]
    @wordbook = params[:wordbook]
    mail(to: @user.email, subject: '私のサイトへようこそ')
  end
end