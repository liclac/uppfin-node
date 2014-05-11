express = require 'express'
lessMiddleware = require 'less-middleware'
coffeeMiddleware = require 'coffee-middleware'

app = express()
app.set 'views', __dirname + '/views'
app.use lessMiddleware(__dirname + '/public')
app.use coffeeMiddleware({src: __dirname + '/public', encodeSrc: false})
app.use express.static(__dirname + '/public')

app.use '/p', require('./p').router
app.use '/s', require('./s').router

app.get '/', (req, res) ->
	res.render 'index.jade'



env = process.env.NODE_ENV || 'development'
port = process.env.PORT || 3000
if env == 'development'
	app.locals.pretty = true

server = app.listen port, ->
	console.log 'Listening on port %d', server.address().port

