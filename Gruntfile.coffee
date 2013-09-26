module.exports = (grunt) ->
	path = require("path")

	grunt.initConfig(
		pkg: grunt.file.readJSON('package.json'),
		gruntconfig:
			out: "out"
			release: "release"
			debug: "debug"
		
		components: "bower_components"
		resource:
			root: "<%= gruntconfig.out %>"
			path: "<%= resource.root %>"
			www: "www"
			js: "<%= resource.www %>/js"
			lib: "<%= resource.js %>/lib"			
			css: "<%= resource.www %>/css"
			img: "<%= resource.www %>/img"

		less:
			debug:
				files:
					"<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.css %>/common.css": "static/less/common.less"
			release:
				files:
					"<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.css %>/common.css": "static/less/common.less"

		clean:
			files:
				src:["<%= resource.root %>"]
			options:
				force: true

		coffee:
			common:
				expand: true
				src: ["*.coffee", "**/*.coffee", "**/**/*.coffee"]
				cwd: "static/coffee/"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.js %>/"
				ext: '.js'
				options:
					bare: true

		requirejs:
			common:
				options:
					name: "app"
					baseUrl: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.js %>/"
					mainConfigFile: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.js %>/app.js"
					out: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.js %>/app.js"

		watch:
			coffee_shell:
				files: ["static/coffee/*.coffee", "static/coffee/**/*.coffee"]
				tasks: ["coffee"]
			less_shell:
				files: "static/less/*.less"
				tasks: ["less"]
			html_shell: 
				files: "static/html/*.html"
				tasks: ["copy:html"]
			img_shell: 
				files: "static/img/**"
				tasks: ["copy:img"]

		copy:
			html:files: [
				flattern: true
				expand: true
				src: "*.html"
				cwd: "static/html"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.www %>"
			,
				flattern: true
				expand: true
				src: "*.html"
				cwd: "static/html"
				dest: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.www %>"
			]
			json:files: [
				flattern: true
				expand: true
				src: "*.json"
				cwd: "static/json"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.www %>/json"
			,
				flattern: true
				expand: true
				src: "*.json"
				cwd: "static/json"
				dest: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.www %>/json"
			]
			img:files: [
				flattern: true
				expand: true
				src: ["**"]
				cwd: "static/img"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.img %>"
			,
				flattern: true
				expand: true
				src: ["**"]
				cwd: "static/img"
				dest: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.img %>"
			]
			jquery:files:[
				flattern: true
				expand: true
				src: "jquery.js"
				cwd: "<%= components %>/jquery/"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.lib %>/jquery/"
			]
			requirejs:files:[
				flattern: true
				expand: true
				src: "require.js"
				cwd: "<%= components %>/requirejs/"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.lib %>/requirejs/"
			,
				flattern: true
				expand: true
				src: "require.js"
				cwd: "<%= components %>/requirejs/"
				dest: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.lib %>/requirejs/"
			]
			backbone:files:[
				flattern: true
				expand: true
				src: "backbone.js"
				cwd: "<%= components %>/backbone/"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.lib %>/backbone/"
			,
				flattern: true
				expand: true
				src: "underscore.js"
				cwd: "<%= components %>/underscore"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.lib %>/underscore"
			]
			domReady:files:[
				flattern: true
				expand: true
				src: "domReady.js"
				cwd: "<%= components %>/requirejs-domready/"
				dest: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.lib %>/requirejs-domready/"
			]

		connect:
			dev:
				options:
					hostname: '*'
					port: 9090 
					base: "<%= resource.root %>/<%= gruntconfig.debug %>/<%= resource.www %>"

			release:
				options:
					hostname: '*'
					port: 9090
					base: "<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.www %>"
					keepalive: true
	)

	grunt.registerTask('css-build-dev', ['less:debug'])
	grunt.registerTask('css-build', ['less:release'])
	grunt.registerTask('js-build-dev', ['coffee'])
	grunt.registerTask('js-build', ['coffee', 'requirejs'])
	grunt.registerTask('build-dev', ['css-build-dev', 'js-build-dev'])
	grunt.registerTask('build', ['css-build', 'js-build'])

	grunt.registerTask('debug', ['clean', 'copy', 'build-dev'])
	grunt.registerTask('debug-run', ['debug', 'connect:dev', 'watch'])
	
	grunt.registerTask('release', ['clean', 'copy', 'build',])
	grunt.registerTask('release-run', ['release', 'connect:release'])
	grunt.registerTask('release-package', ['release', 'compress'])

	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-less"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-contrib-connect"
	grunt.loadNpmTasks "grunt-contrib-watch"