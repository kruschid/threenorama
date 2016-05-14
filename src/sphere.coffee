###*
# Description
# @memberOf threenorama
# @namespace Sphere
###
class Sphere
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  ###
  constructor: (@cameraType) ->
    
  ###*
  # returns number of rows
  # @param {Number} zoom
  # @return {Type}
  ###
  rows: (zoom) ->
    pictureSize = @cameraType.pictureSize(zoom)
    # count/generate rows
    countRows = Math.PI/pictureSize.height


###*
# one line in a sphere
# @memberOf threenorama
# @namespace SphereLine
###
class SphereLine
  ###*
  # Constructor-Description
  ###
  constructor: (posY, pictureSize, circumference) ->


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
    