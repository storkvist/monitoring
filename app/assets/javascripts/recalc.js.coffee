$ ->
  $('.recalc-period').on 'change', ->
    $(this).parent().children('.recalc-result').text(
      ($(this).val() * $(this).data('value')).toFixed(2)
    )