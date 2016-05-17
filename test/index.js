// IMPORTANT: we use here a js file instead of coffee file to load coffeescript based test specs because sourcemap loader somehow isnt able to load coffeescripts sourcemaps 
var testsContext = require.context(".", true, /test.coffee$/);
testsContext.keys().forEach(testsContext); 