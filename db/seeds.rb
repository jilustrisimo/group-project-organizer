# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(email: Faker::Internet.safe_email,
              username: Faker::Internet.user_name,
              password: Faker::Internet.password(10, 20))
end

2.times do
  Project.create(title: Faker::App.name,
                 description: Faker::Lorem.paragraph,
                 due_date: Faker::Time.forward(30))
end

10.times do
  Task.create(title: Faker::Hipster.sentence(3),
                 content: Faker::Lorem.paragraph,
                 due_date: Faker::Time.forward(30))
end

Project.find_by_id(1).tasks << Task.all[0..5]
Project.find_by_id(2).tasks << Task.all[6..-1]
