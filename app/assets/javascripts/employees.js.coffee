$ ->
  $('.toggle-add-assignment').live 'click', ->
    $(this).hide()
    $(this).next().slideDown()

  $('.toggle-close-add-assignment').live 'click', ->
    assignment = $($(this).parents()[2])
    assignment.slideUp()
    assignment.prev().show()