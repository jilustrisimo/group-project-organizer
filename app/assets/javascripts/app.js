$(() => {

  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })

  $('#back').click(() => {
    window.history.back()
  })

  Materialize.updateTextFields()

  $(".button-collapse").sideNav({
      menuWidth: 300,
      edge: 'left',
      draggable: true
  })
})
