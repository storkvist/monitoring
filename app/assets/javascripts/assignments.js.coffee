$ ->
  $('.toggle-add-result').live 'click', ->
    $(this).hide()
    $(this).next().slideDown()

  $('.toggle-close-add-result').live 'click', ->
    assignment = $($(this).parents()[2])
    assignment.slideUp()
    assignment.prev().show()
