$ ->
  $('.toggle-add-result').live 'click', ->
    $(this).hide()
    $(this).next().slideDown()

  $('.toggle-close-add-result').live 'click', ->
    assignment = $($(this).parents()[3])
    debugger
    assignment.slideUp()
    assignment.prev().show()
