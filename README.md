# Group Project Organizer

Group Project Oganizer is a Web App, with a Rails back-end, to help you manage your projects and their associated tasks.  A video walkthrough is listed below.  After signing up you can:

  - Create projects automatically sorted by due date
  - Create tasks automatically associated to their projects
  - View all projects
  - Join and Leave project teams
  - View individual projects and all of the project's tasks
  - Assign and unassign yourself tasks
  - View all of your tasks
  - Mark tasks complete
    * Once all of a project's tasks are completed, the project will be marked completed
  - Delete tasks
  - Delete projects with their associated tasks


  NOTE: *Whenever deleting something you will be prompted to confirm your action.*

You can also:
  - Change your username, e-mail, password or delete account

## Video walkthrough
[![IMAGE ALT TEXT](https://img.youtube.com/vi/SCyzuN-4VOU/0.jpg)](https://www.youtube.com/watch?v=SCyzuN-4VOU "Video Title")

### Heroku Link
[Group Project Organizer](https://sleepy-shelf-44729.herokuapp.com)

## Installation
Clone the repository, then execute:
```
$ bundle
```

## Usage
Migrate the database and load seed data:
```
$ rails db:migrate && rails db:seed
```
To start the server, run:
```
$ rails s
```
Then navigate to ```localhost:3000``` or run:
```
$ open http://localhost:3000
```

#### OAuth
In order to use OAuth authentication you will need to create your own [Facebook](https://developers.facebook.com) and [Google](https://console.developers.google.com/) apps.  [Dotenv](https://github.com/bkeepers/dotenv) is installed to ease loading of environment variables; just set up a .env file in the app's root directory with your keys.
Currently, you will need declare the following environment variables with your app credentials:
```
FACEBOOK_KEY=YourFacebookAppID
FACEBOOK_SECRET=YourFacebookAppSecret
GOOGLE_CLIENT_ID=YourGoogleAppID
GOOGLE_CLIENT_SECRET=YourGoogleAppSecret
```

### Tech

Group Project Organizer uses a number of open source projects to work properly, including:
* [Rails] - A web-application framework that includes everything needed to create database-backed web applications according to the Model-View-Controller (MVC) pattern.
* [Devise] - A flexible authentication solution for Rails based on Warden.
* [Materialize-CSS] - A modern responsive front-end framework based on Material Design.
* [Font Awesome] - A font and CSS toolkit.


And of course Group Project Organizer itself is open source with a [public repository][prjorg]
 on GitHub.


### Todos

 - Add admin console
 - Allow viewing of project team members when joining a project
 - Implement a project leader who can assign tasks to other team members

## Contributing

Bug reports and pull requests are welcome on GitHub at [this project's repository][prjorg]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This Web Application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


   [prjorg]: <https://github.com/jilustrisimo/group-project-organizer>
   [Rails]: <http://rubyonrails.org/>
   [Devise]: <https://github.com/plataformatec/devise>
   [Materialize-CSS]: <http://materializecss.com/>
   [Font Awesome]: <http://fontawesome.io/>
