class TymlMailer < ActionMailer::Base
  default from: "\"TYML\" <tyml@tyml.it>"

  def notification(tyml)
    @tyml = tyml

    mail to: @tyml.receiver_email, subject: "New TYML from #{@tyml.sender.name}"
  end

  def comment_notification(comment)
    @comment = comment
    @comment_receiver = User.find_by_email(comment.tyml.receiver_email)

    if comment.user == comment.tyml.sender
      mail to: @comment.tyml.receiver_email, subject: "TYML: New comment from #{@comment.tyml.sender.name}"
    else
      mail to: @comment.tyml.sender.email, subject: "TYML: New comment from #{@comment_receiver.name}"
    end
  end
end
