$(() => {

  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })

  $('#back').click(() => {
    window.history.back()
  })

  Materialize.updateTextFields()
})
