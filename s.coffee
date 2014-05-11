express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
	res.render('s/index.jade')

exports.router = router
