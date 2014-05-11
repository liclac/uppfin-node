$ 'form'
	.on 'submit', ->
		$.get 'api', {'url': $('#url').val()}, (data) ->
			console.log(data)
		return false
