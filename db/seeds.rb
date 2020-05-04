User.create!(name: 'John Doe',
             username: 'JohnDoe123',
             email: 'johndoe@example.com',
             password: 'foobar',
             password_confirmation: 'foobar')

# Create users
40.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  username = "example-#{n+1}"
  password = 'foobar'
  User.create!(name: name,
               email: email,
               username: username,
               password: password,
               password_confirmation: password)
end

# Create user previous events (skip validations)
users = User.take(20)
users.each do |user|
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(sentence_count: 6)
  location = Faker::Address.full_address
  start_date = Faker::Date.between(from: 30.days.ago, to: 15.days.ago)
  end_date = Faker::Date.between(from: 14.days.ago, to: 2.days.ago)

  user.events.new(title: "#{title}",
                  description: description,
                  location: location,
                  start_date: start_date,
                  end_date: end_date).save(validate: false)

end

# Create user upcoming events
users.each do |user|
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(sentence_count: 6)
  location = Faker::Address.full_address
  start_date = Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now)
  end_date = Faker::Date.between(from: 30.days.from_now, to: 60.days.from_now)

  user.events.create!(title: "#{title} #{user.name}",
                      description: description,
                      location: location,
                      start_date: start_date,
                      end_date: end_date)
end

# Associate attendees(users) and events
users = User.take(5)
events = Event.all
events.each do |event|
  users.each do |user|
    user.invitations.create!(event_id: event.id)
  end
end