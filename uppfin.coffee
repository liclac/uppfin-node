express = require 'express'
lessMiddleware = require 'less-middleware'
coffeeMiddleware = require 'coffee-middleware'

app = express()
app.use lessMiddleware(__dirname + '/public')
app.use coffeeMiddleware({src: __dirname + '/public', encodeSrc: false})
app.use express.static(__dirname + '/public')

app.use '/p', require('./p').router
app.use '/s', require('./s').router

app.get '/', (req, res) ->
	res.render 'index.jade'



env = process.env.NODE_ENV || 'development'
if env == 'development'
	app.locals.pretty = true

server = app.listen 3000, ->
	console.log 'Listening on port %d', server.address().port
