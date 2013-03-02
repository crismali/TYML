class Contact < ActiveRecord::Base
  attr_accessible :contact_email, :user_id

  validates_presence_of :contact_email, :user_id

  validate :unique_pair_of_users

  def unique_pair_of_users
    unless Contact.where(user_id: self.user_id, contact_email: self.contact_email).blank?
      errors.add(:receiver_email, "must be valid")
      logger.info(errors.inspect)
    end
  end

  belongs_to :user
end
