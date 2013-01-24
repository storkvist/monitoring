$ ->
  $('.toggle-add-assignment').on 'click', ->
    $(this).hide()
    $(this).next().slideDown()

  $('.toggle-close-add-assignment').on 'click', ->
    assignment = $($(this).parents()[2])
    assignment.slideUp()
    assignment.prev().show()