# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  User.create(email: Faker::Internet.safe_email,
              username: Faker::Internet.user_name,
              password: Faker::Internet.password(10, 20))
end

10.times do
  Project.create(title: Faker::App.name,
                 description: Faker::Hipster.paragraph,
                 due_date: Faker::Date.forward(90))
end

Project.all.each do |project|
  5.times do
    project.tasks.build(title: Faker::Commerce.product_name,
                        content: Faker::Hipster.paragraph,
                        due_date: Faker::Date.between(Date.today, project.due_date))
           .save
  end
end

5.times do
  User.all.each do |user|
    user.tasks << Task.all.sample
    user.tasks.last.project.team_members << user
  end
end
