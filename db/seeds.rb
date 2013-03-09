User.destroy_all
Tyml.destroy_all
Contact.destroy_all
Comment.destroy_all

users = [
  {name: 'Mike McGee', email: 'mike@starterleague.com', profile_pic: 'http://assets2.starterleague.com/assets/mike-mcgee-16075ffb857b541ef073ddb483c9bca6.jpg', bio: 'I did cool things', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Michael Crismali', email: 'michael.crismali@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/michael-crismali-01525144b8bc333ee687fbb51832f2ca.jpg', bio: 'I went to a hippy school', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Natasha Postolovski', email: 'npostolovski@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/natasha-postolovski-709bd16708b02bffca8a35e9c75ac809.jpg', bio: 'I did even cooler things', location: 'Melbourne, AU', password: 'woohoo' },
  {name: 'Peter Ostrander', email: 'peter.ostrander@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/peter-ostrander-33542548f4158794e11eb689e08eec6c.jpg', bio: 'I have to go to the airport', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Elizabeth Park', email: 'elibeee@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/elizabeth-park-42c231497c42a6bf78202b8541188f9b.jpg', bio: 'I like mockups', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Archie Algas', email: 'archie.algas@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/archie-algas-8cb8248639404527654c53b61a1df0e5.jpg', bio: 'I like mockups even more', location: 'Chicago, IL', password: 'woohoo' }
]

User.create users

puts 'Created users'

User.all.each do |user|

  User.all.each do |user2|
    c = Contact.new
    c.user_id = user.id
    unless user2.id == user.id
      c.contact_email = user2.email
      c.save
    end
  end
end

puts 'Created contacts'

comments = [ "Thank you... I'd never heard of this wonderful service before!", "Whaaaat???", "OMG this is hilarious.", "I don't get it?", "Did you do this?", "I AM DEEPLY OFFENDED.", "You always know what I like :)", "You should have thought a little bit harder." ]
notes = [ "This is HIGHLY relevant to your interests.", "You'll hate this.", "Get ready for awesome.", "This is super fascinating and I thought you might like it based on your interest in lucid dreaming and our interactions as friends.", "Do you love this???", "TELL ME IF YOU GOT THIS ONE OK?", "LOL.", "This is ridiculous but I love it.", "LoLL YoU ArE CCoooL!" ]
urls = [ 'http://www.yelp.com/', 'https://www.google.com/', 'https://twitter.com/', 'http://wikipedia.org/', 'https://twitter.com/jeffcohen', 'http://mikeylikey.tumblr.com/', 'http://tyml.it', 'http://theonion.com', 'http://feralaudio.com/show/call-chelsea-peretti/' ]

100.times do
  tyml = Tyml.new
  tyml.note = notes[rand(9)]
  tyml.url = urls[rand(8)]
  tyml.sender_id = User.offset(rand(6)).first.id
  tyml.receiver_email = User.offset(rand(6)).first.email

  if rand(2) == 1
    tyml.viewed = true
  else
    tyml.viewed = false
  end

  tyml.save
end

puts 'Created 100 tymls'

100.times do
  c = Comment.new
  c.user_id = User.offset(rand(6)).first.id
  c.tyml_id = Tyml.offset(rand(100)).first.id
  c.comment_text = comments[rand(8)]
  c.save
end

puts 'Created 25 comments'
