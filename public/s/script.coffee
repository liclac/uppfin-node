$ 'form'
	.on 'submit', ->
		$.get '_api', {'url': $('#url').val()}, (data) ->
			$('#shortlink').html data
		return false
