class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation" do |format|
    format.text(content_transfer_encoding: "7bit")
    format.html(content_transfer_encoding: "7bit")
    end

  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end

end