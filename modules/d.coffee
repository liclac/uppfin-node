express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
    res.render('d/index.jade')

exports.router = router
