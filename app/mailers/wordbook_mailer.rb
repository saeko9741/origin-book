class WordbookMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def wordbook_email
    @user = params[:user]
    @wordbook = params[:wordbook]
    mail(to: @user.email, subject: 'ORIGIN BOOK')
  end
end