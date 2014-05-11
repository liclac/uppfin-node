express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
	res.set('Content-Type', 'text/plain')
	res.send("Not yet implemented")

exports.router = router
