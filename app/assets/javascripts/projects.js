//// CONSTRUCTOR ////

function Project(project) {
  this.id = project.id
  this.title = project.title
  this.description = project.description
  this.dueDate = moment(project.due_date)
  this.completed = project.completed
  this.updatedAt = moment(project.updated_at)
  this.project_teams = project.project_teams
  this.team = project.team
  this.teamMembers = project.team_members
  this.tasks = project.tasks
  this.isCompleted = project.is_completed
  this.teamMember = project.is_team_member
  this.isPastDueDate = project.is_past_due_date
  this.remainingTasks = project.remaining_tasks_count
  this.unassignedTasks = project.unassigned_tasks_count
}

//// PROTOTYPE METHODS ////

Project.prototype.formatDueDate = function() {
  let dueDateFormat
    if (this.isPastDueDate){
      dueDateFormat = `<p class="left red-text" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    } else {
      dueDateFormat = `<p class="left" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    }
    return dueDateFormat
}

Project.prototype.formatTasks = function(task) {

  let username = task.user ? `<p><strong>Assigned to:</strong> ${task.user}</p>` : ''

  return `
  <div class="card-panel hoverable center-align">
    ${taskIcon(task)}
    <a href="/projects/${task.project_id}/tasks/${task.id}/edit">
      <h5 class="truncate"><b>${task.title}e</b></h5>
      <p>${task.content}</p>
      ${username}
      <small class="left"><b>Due Date</b></small><br>
      ${taskDueDate(task)}
      <a class="right btn-flat-small waves-effect waves-red" data-confirm="Are you sure you want to delete ${task.title}?" rel="nofollow" data-method="delete" href="/projects/${task.project_id}/tasks/${task.id}">
        <i class="material-icons">delete</i>
      </a><br>
    </a>`

}

Project.prototype.formatIndex = function() {

  return `
    <div class="card-panel hoverable">
      ${indexIcon(this)}
      <a href="/projects/${this.id}" class="show" id="${this.id}">
        <div class="center-align">
          <h3 class="break truncate"><b>${this.title}</b></h3>
          <p>${this.description}</p><br>
          <small class="left"><b>Due Date</b></small><br>
          ${this.formatDueDate()}
        </div>
      </a>
    </div>
  `
}

Project.prototype.formatShow = function() {

  return `
    ${completedIcon(this)}
    <div class="center-align">
      <h3 class="truncate">
        ${this.title}
      </h3>

      <h5>
        ${this.description}
      </h5>
    <p class="left-align">
      <strong>Due date</strong><br>
      ${this.formatDueDate()}
    </p>
    <div class="divider"></div>
      <table style="table-layout: fixed; margin-top: 10px">
      <caption style="font-size: 160%">Tasks Overview</caption>
      <thead>
        <tr>
          <th>Incompleted</th>
          <th>Unassigned</th>
          <th>Completed</th>
          <th>Total</th>
        </tr>
      </thead>
      <tr>
        <td>${this.remainingTasks}</td>
        <td>${this.unassignedTasks}</td>
        <td>${this.remainingTasks - this.unassignedTasks}</td>
        <td>${this.tasks.length}</td>
      </tr>
    </table>
  </div>
  <div class="fixed-action-btn">
    <a class="btn-floating btn-large teal accent-4">
      <i class="large material-icons">menu</i>
    </a>
    <ul>
      <li><a href="/projects/${this.id}/tasks/new" class="btn-floating tooltipped green" data-tooltip="create a new task" data-position="left"><i class="material-icons">note_add</i></a></li>
      <li><a href="/projects/${this.id}/edit" class="btn-floating tooltipped yellow" data-tooltip="edit project" data-position="left"><i class="material-icons">mode_edit</i></a>
      </li>
      <li>
        <a class="btn-floating tooltipped red" data-tooltip="delete project" data-position="left" data-confirm="Are you sure you want to delete ${this.title} and all its tasks?" rel="nofollow" data-method="delete" href="/projects/${this.id}">
            <i class="material-icons">delete</i>
        </a>
      </li>
      <li>
        <a class="btn-floating tooltipped orange" data-tooltip="leave project team" data-position="left" data-confirm="Are you sure you want to leave ${this.title}'s team?" rel="nofollow" data-method="delete" href="/project_teams/${this.team}">
          <i class="material-icons">fast_rewind</i>
        </a>
      </li>
    </ul>
  </div>
  `
}

//// HELPER FUNCTIONS ////

const indexIcon = project => {
    if (project.isCompleted){
      return `<a href="#" class="teal-text bold left">
                <i class="material-icons teal-text">done_all</i> <strong>Project Completed:</strong> ${project.updatedAt.format('dddd, D MMMM YYYY')}
              </a> <br>`
    } else if (project.teamMember){
      return `<i class="material-icons teal-text">lock_open</i>`
    } else {
      return `<a href="/project_teams?project_id=${project.id}" data-method="post" class="btn-small tooltipped teal accent-4 white-text left" data-tooltip="join project team" data-position="top"><i class="material-icons">add</i></a>
      <br>`
    }
}

const taskIcon = task => {

    if (task.completed) {
      return `
        <a class="btn-flat-small tooltipped waves-effect waves-teal left" data-tooltip="Mark Incomplete" data-position="top" rel="nofollow" data-method="patch" href="/projects/${task.project_id}/tasks/${task.id}?task%5Bcompleted%5D=false">
          <i class="material-icons teal-text">done</i><span class="teal-text"><strong>Completed:</strong> ${task.updated_at}</span>
        </a><br>`
    } else if (task.user_id == null) {
      return `
        <a href="/users/${$('#main').data('user')}/tasks/${task.id}/edit" data-method="post" class="btn-small tooltipped teal accent-4 white-text left" data-tooltip="assign yourself to this task" data-position="top"><i class="material-icons">add</i></a><br>`
    } else if (task.is_current_user_task) {
      return `
        <a class="btn-flat-small tooltipped waves-effect waves-teal left" data-tooltip="Mark Complete" data-position="top" rel="nofollow" data-method="patch" href="/projects/${task.project_id}/tasks/${task.id}?task%5Bcompleted%5D=true">
          <i class="material-icons teal-text">turned_in</i>
        </a><br>`
    } else {
      return ''
    }
}

const taskDueDate = task => {
    if (task.is_past_due_date){
      return `<p class="left red-text" style="margin: 0">${task.due_date}</p><br>`
    } else {
      return `<p class="left" style="margin: 0">${task.due_date}</p><br>`
    }
}

const completedIcon = project => {
    if (project.isCompleted) {
      return `<a href="#" class="teal-text bold left"><i class="material-icons teal-text">done_all</i> <strong>Project Completed:</strong> ${project.updatedAt.format('dddd, D MMMM YYYY')}</a>
      <br>`
    } else { 
      return ''
    }
}

//// EVENT LISTENERS ////

const bindClickHandlers = () => {
  $('.all-projects').on('click', e => {
    e.preventDefault()
    history.pushState(null, null, '/projects')
    $.get('/projects.json', projects => {
      $('#main').html('<h1 class="center">All Projects</h1>')
      $.each(projects, (idx,val) => {
        let project = new Project(val)
        let projectHtml = project.formatIndex()
        $('#main').append(projectHtml)
      })
      bindShowListeners()
      $('.tooltipped').tooltip({delay: 50})
    })
  })

  $('#new_task').on('submit', e => {
    e.preventDefault()
    let id = e.currentTarget.getAttribute('project')
    history.pushState(null, null, `/projects/${id}`)
    $.post(e.currentTarget.action, $(e.currentTarget).serialize(), resp => {
      $('#main').html('')
      let project = new Project(resp)
      let projectShowHtml = project.formatShow()
      $('#main').append(projectShowHtml)
      $.each(project.tasks, (idx,task) => {
        let taskHtml = project.formatTasks(task)
        $('#main').append(taskHtml)
      })
      $('.tooltipped').tooltip({delay: 50})
    })
  })
}

const bindShowListeners = () => {
  $('.show').on('click', e => {
    e.preventDefault()
    let id = e.currentTarget.id
    history.pushState(null, null, `/projects/${id}`)
    $.get('/projects/' + id + '.json', val => {
      $('#main').html('')
      let project = new Project(val)
      let projectShowHtml = project.formatShow()
      $('#main').append(projectShowHtml)
      $.each(project.tasks, (idx,task) => {
        let taskHtml = project.formatTasks(task)
        $('#main').append(taskHtml)
      })
      $('.tooltipped').tooltip({delay: 50})
    })
  })
}

$(() => {
  bindClickHandlers()
  bindShowListeners()
})