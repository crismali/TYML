class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :bio, :email, :location, :name, :profile_pic

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_many :sent_tymls, class_name: 'Tyml', foreign_key: 'sender_id'
  has_many :received_tymls, class_name: 'Tyml', foreign_key: 'receiver_email'

end
