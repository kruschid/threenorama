module.exports = (config) ->
  config.set
    # base path that will be used to resolve all patterns
    basePath: '../'
    
    preprocessors:
      'test/index.js': ['webpack', 'sourcemap']

    # import webpack config
    webpack: require('../webpack.config.js')
    
    # frameworks to use
    frameworks: ['mocha', 'chai']

    # list of files / patterns to load in the browser
    files: [
      'test/index.js'
    ]
          
    # test result reporter
    reporters: ['mocha']
    # enable / disable colors in the output (reporters and logs)
    colors: true

    # start these browsers
    browsers: ['PhantomJS']
