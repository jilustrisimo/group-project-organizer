$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all-projects').on('click', e => {
    e.preventDefault()
    $.get('/projects.json', projects => {
      $('#main').html('<h1 class="center">All Projects</h1>')
      $.each(projects, (idx,val) => {
        let project = new Project(val)
        let projectHtml = project.formatIndex()
        $('#main').append(projectHtml)
      })
    })
  })
}

function Project(project) {
  // id, description, due_date, completed, updated_at, project_teams, project_members, tasks
  this.id = project.id
  this.title = project.title
  this.description = project.description
  this.due_date = moment(project.due_date)
  this.completed = project.completed
  this.updated_at = project.updated_at
  this.project_teams = project.project_teams
  this.team_members = project.team_members
  this.tasks = project.tasks
}

Project.prototype.formatIndex = function() {
  let projectHtml = `
    <div class="card-panel hoverable">
      <a href="/projects/${this.id}" class="show">
        <div class="center-align">
          <h3 class="break truncate"><b>${this.title}</b></h3>
          <p>${this.description}</p><br>
          <small class="left"><b>Due Date</b></small><br>
            <p class="left" style="margin: 0">${this.due_date.format('dddd, D MMMM YYYY')}</p><br>
        </div>
      </a>
    </div>
  `
  return projectHtml
}

// Project.prototype.