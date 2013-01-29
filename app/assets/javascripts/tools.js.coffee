$ ->
  $('#only_different_employees').click ->
    if this.checked
      $('.table-similar tbody tr').each ->
        $(this).hide() if ($(this).data('e1') == $(this).data('e2'))
    else
      $('.table-similar tbody tr').each ->
        $(this).show()
