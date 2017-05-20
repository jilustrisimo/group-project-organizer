function Project(project) {
  this.id = project.id
  this.title = project.title
  this.description = project.description
  this.dueDate = moment(project.due_date)
  this.completed = project.completed
  this.updatedAt = moment(project.updated_at)
  this.project_teams = project.project_teams
  this.teamMembers = project.team_members
  this.tasks = project.tasks
  this.isCompleted = project.is_completed
  this.teamMember = project.is_team_member
  this.isPastDueDate = project.is_past_due_date
}

Project.prototype.formatIndex = function() {
  let icon
    if (this.isCompleted){
      icon = `<a href="#" class="teal-text bold left">
                <i class="material-icons teal-text">done_all</i> <strong>Project Completed:</strong> ${this.updatedAt.format('dddd, D MMMM YYYY')}
              </a> <br>`
    } else if (this.teamMember){
      icon = `<i class="material-icons teal-text">lock_open</i>`
    } else {
      icon = `<a href="/project_teams?project_id=${this.id}" data-method="post" class="btn-small tooltipped teal accent-4 white-text left" data-tooltip="join project team" data-position="top"><i class="material-icons">add</i></a>
      <br>`
    }

  let dueDateFormat
    if (this.isPastDueDate){
      dueDateFormat = `<p class="left red-text" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    } else {
      dueDateFormat = `<p class="left" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    }

  let projectHtml = `
    <div class="card-panel hoverable">
      ${icon}
      <a href="/projects/${this.id}" class="show" id="${this.id}">
        <div class="center-align">
          <h3 class="break truncate"><b>${this.title}</b></h3>
          <p>${this.description}</p><br>
          <small class="left"><b>Due Date</b></small><br>
          ${dueDateFormat}
        </div>
      </a>
    </div>
  `
  return projectHtml
}

Project.prototype.formatShow = function() {
  let completedIcon
    if (this.isCompleted) {
      completedIcon = `<a href="#" class="teal-text bold left"><i class="material-icons teal-text">done_all</i> <strong>Project Completed:</strong> ${this.updatedAt.format('dddd, D MMMM YYYY')}</a>
      <br>`
    }
  
  let projectDetails = `
    <div class="center-align">
    <h3 class="truncate">
      ${this.title}
    </h3>

    <h5>
      ${this.description}
    </h5>`
    
    
  let projectDueDate
    if (this.isPastDueDate){
      projectDueDate = `
      <p class="left red-text" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    } else {
      projectDueDate = `
      <p class="left" style="margin: 0">${this.dueDate.format('dddd, D MMMM YYYY')}</p><br>`
    }

  let formatShow = `
    ${completedIcon}
    ${projectDetails}
    <p class="left-align">
      <strong>Due date</strong><br>
      ${projectDueDate}
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
    `
}

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
      bindShowListeners()
    })
  })
}

const bindShowListeners = () => {
  $('.show').on('click', e => {
    e.preventDefault()
    let id = e.currentTarget.id
    $.get('/projects/' + id + '.json', project => {
      $('#main').html('')
      let projectShowHtml = project.formatShow()
    })
  })
}

$(() => {
  bindClickHandlers()
})