class Tyml < ActiveRecord::Base

  validate :valid_email

  def valid_email
    unless receiver_email[/.+@.+/]
      errors.add(:receiver_email, "must be valid")
      logger.info(errors.inspect)
    end
  end

  attr_accessible :note, :receiver_email, :sender_id, :url, :viewed


  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_email'


end
