$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all-projects').on('click', e => {
    e.preventDefault()
    $.get('/projects.json', projects => {
      $('.main').html('')
      $.each(projects, (idx,val) => {
        console.log(val)
      })
    })
  })
}