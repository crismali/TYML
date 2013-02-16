class Tyml < ActiveRecord::Base
  attr_accessible :note, :receiver_id, :sender_id, :url, :viewed


  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'


end
