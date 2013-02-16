class Tyml < ActiveRecord::Base

  validate :cant_send_link_more_once_per_day

  def cant_send_link_more_once_per_day
    last_tyml = Tyml.where(:sender_id => self.sender_id, :receiver_id => self.receiver_id, :url => self.url).last
    unless last_tyml.nil?
      if Date.today.strftime('%a %d %b %Y') == last_tyml.created_at.strftime('%a %d %b %Y')
        errors.add( :Error, ": you can't send the same tyml more than once per day")
      end
    end

  end


  attr_accessible :note, :receiver_id, :sender_id, :url, :viewed


  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'


end
