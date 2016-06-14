fabric = require('fabric').fabric

###*
# Description
# @memberOf threenorama
# @namespace Canvas
###
module.exports = class Canvas extends fabric.Canvas
  ###*
  # Constructor-Description
  # @param {HTMLElement} el
  # @param {Object} [options] Options object
  ###
  constructor: (el, options)->
    super(el, options)

  ###*
  # rad to px converter
  # @return {Number} px value
  ###
  fromTilt: (tilt) ->
    @height * tilt/Math.PI

  ###*
  # rad to px converter
  # @return {Number} px value
  ###
  fromPan: (pan) ->
    @width * pan/Math.PI/2

  ###*
  # px to rad converter
  # @return {Number} rad value
  ###
  toTilt: (top) -> 
    top/@height * Math.PI

  ###*
  # px to rad converter
  # @return {Number} rad value
  ###
  toPan: (left) ->
    left/@width * Math.PI*2