class User < ActiveRecord::Base
  attr_accessible :bio, :email, :location, :name, :profile_pic

  has_many :tymls

end
