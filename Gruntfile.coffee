module.exports = (grunt) ->
	grunt.initConfig({
		'pkg': grunt.file.readJSON('package.json'),
		'nodemon': {
			'dev': {
				'script': 'uppfin.coffee',
				'options': {
					'ignore': ['public/**']
				}
			}
		}
	})
	
	grunt.loadNpmTasks('grunt-nodemon')
	
	grunt.registerTask('default', ['nodemon'])
