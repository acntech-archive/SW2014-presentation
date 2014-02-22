'use strict'
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    connect:
      server:
        options:
          port: 9000
          hostname: '*'
          base: 'dist'
     stylus:
      compile:
        options:
          linenos: true
          compress: false
        files: [
          expand: true
          src: '**/*.styl'
          cwd: 'assets/styles/'
          dest: 'dist/assets/styles/'
          ext: '.css'
        ]
    coffee:
      compile:
        files: [
          expand: true
          src: '**/*.coffee'
          cwd: 'assets/scripts/'
          dest: 'dist/assets/scripts'
          ext: '.js'
        ]
    jade:
      compile:
        files: [
          expand: true
          src: 'index.jade'
          dest: 'dist/'
          ext: '.html'
        ]
    open:
      # change to the port you're using
      server:
        path: "http://localhost:<%= connect.server.options.port %>?LR-verbose=true"

    copy:
      img:
        files: [
            expand: true
            src: ['**/*.{png,jpg,jpeg,gif,webp,svg}']
            cwd: 'assets/images'
            dest: 'dist/assets/images/'
        ]
      fonts:
        files: [
            expand: true
            src: ['**/*.{eot,svg,ttf,woff}']
            cwd: 'assets/fonts'
            dest: 'dist/assets/fonts/'
        ]
      css:
        files: [
          expand: true
          src: '**/*.css'
          cwd: 'assets/styles'
          dest: 'dist/assets/styles/'
        ]
      javascript: 
        files: [
          expand: true
          src: '**/*.js'
          cwd: 'assets/scripts'
          dest: 'dist/assets/scripts/'
        ]
      bower_components:
        files: [
          expand: true
          src: '**/*.*'
          cwd: 'vendor'
          dest: 'dist/vendor'
        ]
    watch:
      options:
        livereload: true
      stylus:
        files:
          ['assets/styles/**/*.styl']
        tasks: 'stylus'
        options:
          livereload: false
      coffee:
        files:
          ['assets/scripts/**/*.coffee']
        tasks: 'coffee'
        options:
          livereload: false
      jade:
        files:
          ['**/*.jade']
        tasks: 'jade'
        options:
          livereload: true
      img:
        files:
          ['assets/**/*.{png,jpg,jpeg,gif,webp,svg}']
        tasks: 'copy:img'
        options:
          livereload: false
      css:
        files:
            ['assets/styles/**/*.css']
          tasks: 'copy:css'
          options:
            livereload: false
      dist:
        files: ['dist/**', 'dist/assets/**/*.*']
    clean: ['dist']

  grunt.registerTask 'server', [ 'clean', 'copy', 'jade', 'stylus', 'coffee', 'connect:server', 'watch' ]
