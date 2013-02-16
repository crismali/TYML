class TymlMailer < ActionMailer::Base
  default from: "tyml@tyml.co"

  def notification(tyml)
    @tyml = tyml

    mail to: @tyml.receiver.email, subject: "New TYML from #{@tyml.sender.name}"
  end
end
