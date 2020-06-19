class TestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def test_email
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: '私のサイトへようこそ')
  end
end
