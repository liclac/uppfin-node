express = require 'express'
marked = require 'marked'
fs = require 'fs'
router = express.Router()

router.get '/', (req, res) ->
    res.render('d/index.jade')

router.get '/:filename', (req, res) ->
    fs.readFile __dirname + '/../docs/' + req.param('filename'), 'utf8', (err, data) ->
        if(!err)
            res.render('d/doc.jade', {
                doc: req.param('filename'),
                content: marked(data)
                })
        else
            res.render('404.jade')

exports.router = router
