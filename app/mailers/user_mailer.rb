class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Активация аккаунта' do |format|
      format.text(content_transfer_encoding: '7bit')
      format.html(content_transfer_encoding: '7bit')
    end
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Восстановление пароля'
  end
end
