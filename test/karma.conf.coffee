module.exports = (config) ->
  config.set
    # base path that will be used to resolve all patterns
    basePath: '../'
    
    preprocessors:
      '**/*.coffee': ['coffee']
 
    coffeePreprocessor: 
      # options passed to the coffee compiler
      options:
        bare: true
        sourceMap: true
      # transforming the filenames
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')
    
    # frameworks to use
    frameworks: ['mocha', 'chai', 'sinon']

    # list of files / patterns to load in the browser
    files: [
      # 'bower_components/angular/angular.js'
    ]
    # test result reporter
    reporters: ['mocha']
    # enable / disable colors in the output (reporters and logs)
    colors: true
      
    # enable / disable watching file and executing tests whenever any file changes
    # autoWatch: true,

    # start these browsers
    browsers: ['PhantomJS']