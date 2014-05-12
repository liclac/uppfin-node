express = require 'express'
Datastore = require 'nedb'

router = express.Router()
db = new Datastore {filename: __dirname + '/data/s.db'}
db.loadDatabase (err) ->
	if err
		console.log "Couldn't load s.db: " + err
	else
		db.ensureIndex({fieldName: 'key', unique: true})
		db.ensureIndex({fieldName: 'url', unique: true})

router.get '/', (req, res) ->
	res.render 's/index.jade'

router.get '/_api', (req, res) ->
	base = req.protocol + "://" + req.get('host') + "/s/"
	res.set 'Content-Type', 'text/plain'
	
	# Normalize the URL
	url = req.query.url
	if url.indexOf("://") == -1
		url = "http://" + url
	if url[url.length-1] == '/'
		url = url.slice 0, -1
	
	# Short-circuit if it's an already shortened link
	if url.indexOf('http://uppf.in') == 0
		res.send url
		return
	
	db.find {url: url}, (err, docs) ->
		if err
			res.send 500, "Error: " + err
		else if docs.length > 0
			res.send base + docs[0].key
		else
			insertfn = (url) ->
				characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
				key = ""
				key += characters[Math.floor(Math.random() * characters.length)] for [1..5]
				db.count {key: key}, (err, count) ->
					if err
						res.send 500, "Error: " + err
					else if count == 0
						db.insert {url: url, key: key}, (err, newDoc) ->
							res.send base + newDoc.key
					else
						insertfn url
			insertfn url

router.get '/:key', (req, res) ->
	db.find {key: req.param('key')}, (err, docs) ->
		if docs.length > 0
			res.redirect 301, docs[0].url
		else
			set.set 'Content-Type', 'text/plain'
			res.send 404, "Invalid link"

exports.router = router
