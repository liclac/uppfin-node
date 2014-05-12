$ 'form'
	.on 'submit', ->
		$.get 'api', {'url': $('#url').val()}, (data) ->
			$('#shortlink').html data
		return false
