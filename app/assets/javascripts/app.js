$(() => {

  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })

  $('.fixed-action-btn').click(() => {
    window.history.back()
  })
})
