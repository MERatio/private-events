User.create!(name: 'John Doe',
             username: 'JohnDoe123',
             email: 'johndoe@example.com',
             password: 'foobar',
             password_confirmation: 'foobar')

99.times do |n|
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

users = User.order(:created_at).take(10)
50.times do
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(sentence_count: 6)
  location = Faker::Address.full_address
  start_date = Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now)
  end_date = Faker::Date.between(from: 30.days.from_now, to: 60.days.from_now)

  users.each do |user| 
    user.events.create!(title: "#{title} #{user.name}",
                        description: description,
                        location: location,
                        start_date: start_date,
                        end_date: end_date)
  end
end