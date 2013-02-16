class TymlMailer < ActionMailer::Base
  default from: "\"TYML\" <tyml@tyml.it>"

  def notification(tyml)
    @tyml = tyml

    mail to: @tyml.receiver.email, subject: "New TYML from #{@tyml.sender.name}"
  end
end
