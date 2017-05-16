$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all-projects').on('click', e => {
    e.preventDefault()
    $.get('/projects.json', projects => {
      $('.main').html('')
      $.each(projects, (idx,val) => {
        let project = new Project(val)
        console.log(project)
      })
    })
  })
}

function Project(project) {
  // id, description, due_date, completed, updated_at, project_teams, project_members, tasks
  this.id = project.id
  this.description = project.description
  this.due_date = project.due_date
  this.completed = project.completed
  this.updated_at = project.updated_at
  this.project_teams = project.project_teams
  this.team_members = project.team_members
  this.tasks = project.tasks
}