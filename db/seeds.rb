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

  %w(1..3).sample.to_i.times do
    project.tasks.sample.update(completed: true)
  end
end

User.all.each do |user|
  %w(2..4).sample.to_i.times do
    user.tasks << Task.all.sample
    user.tasks.last.project.team_members << user
  end
end

Project.all.sample.tasks.update_all(completed: true)

titles = ['Incompleted Project', 'Completed Project']
descriptions = ['This project should be towards the top of your page as it is incomplete. Notice how projects and tasks are grouped by completion status then sorted by due date.', 'This project should be towards the bottom of the page and marked completed.  It should not be accessible as you are unable to join a completed project you are not already a member of. NOTE: if you see this at the top of your page after just creating this data hit refresh.  For some reason the order is reversed when data is generated the first time.']

project = Project.create(title: titles[0], description: descriptions[0], due_date: Faker::Date.forward(5))

project2 = Project.create(title: titles[1], description: descriptions[1], due_date: Faker::Date.forward(5))

5.times do
  project.tasks.build(title: Faker::Commerce.product_name,
                      content: Faker::Hipster.paragraph,
                      due_date: Faker::Date.between(Date.today, project.due_date))
         .save
end

2.times do
  project2.tasks.build(title: Faker::Commerce.product_name,
                       content: Faker::Hipster.paragraph,
                       due_date: Faker::Date.between(Date.today, project2.due_date),
                       completed: true)
          .save
end

project.tasks[0..1].each { |t| t.update(completed: true) }
project2.tasks.each { |t| t.update(completed: true) }
