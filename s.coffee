express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
	res.render('s/index.jade')

router.get '/api', (req, res) ->
	res.set('Content-Type', 'text/plain')
	res.send(req.query.url)

exports.router = router
