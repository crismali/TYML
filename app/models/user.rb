class User < ActiveRecord::Base
  attr_accessible :bio, :email, :location, :name, :profile_pic

  has_many :sent_tymls, class_name: 'Tyml', foreign_key: 'sender_id'
  has_many :received_tymls, class_name: 'Tyml', foreign_key: 'receiver_id'

end
