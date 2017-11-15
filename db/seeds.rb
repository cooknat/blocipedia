require 'faker'


25.times do
    User.create!(
      username: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.unique.password
      confirmed_at: Time.now
)
end
users = User.all


100.times do
    Wiki.create!(
      user: users.sample,
      private: false,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph
)
end
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"