express = require 'express'
lessMiddleware = require 'less-middleware'

app = express()
app.use lessMiddleware(__dirname + '/public')
app.use express.static(__dirname + '/public')

app.get '/', (req, res) ->
	res.render 'index.jade'

env = process.env.NODE_ENV || 'development'
if env == 'development'
	app.locals.pretty = true

server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
