###*
# Description
# @memberOf threenorama
# @namespace Sphere
###
class Sphere
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} zoom
  ###
  constructor: (@cameraType, @zoom) ->
    
  ###*
  # returns number of rows
  # @return {Type}
  ###
  rows: ->
    pictureSize = @cameraType.pictureSize(@zoom)
    # tilt range
    tiltRange = @cameraType.tiltMax - @cameraType.tiltMin
    # count/generate rows
    countRows = Math.ceil(tiltRange/pictureSize.height)
    deltaTilt = tiltRange/countRows
    console.log 'deltaTilt', deltaTilt
    # for i in [1..countRows] # for each row
      # calculate circumreference
      # tilt = @cameraType.tiltMin * i*deltaTilt
      # circumference = Math.sin(tilt)*panRange
      # create SphereLine
      # lines.push(new SphereLine(tilt, pictureSize, circumference))
    countRows


###*
# one line in a sphere
# @memberOf threenorama
# @namespace SphereLine
###
class SphereLine
  ###*
  # Constructor-Description
  ###
  constructor: (tilt, pictureSize, circumference) ->


###*
# one cell in a sphere
# @memberOf threenorama
# @namespace SphereCell
###
class SphereCell
  ###*
  # Constructor-Description
  ###
  constructor: (pos, pictureSize) ->
    