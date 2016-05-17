###*
# Description
# @memberOf threenorama
# @namespace Sphere
###
module.exports.Sphere = class Sphere
  
  # @var {Number} panMin pan arc start point in radians
  # @var {Number} panMax pan arc end point in radians
  # @var {Number} tilMin tilt arc start point in radians
  # @var {Number} tilMax tilt arc end point in radians
  # @var {Number} panArc arc length in radians
  # @var {Number} tiltArc arc length in radians
  
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} zoom
  ###
  constructor: (cameraType, @pictureSize) ->
    #init params
    {
      @panMin 
      @panMax
      @tiltMin
      @tiltMax
    } = cameraType
    # compute horizontal circumference
    @panArc = @panMax - @panMin
    # compute vertical circumference
    @tiltArc = @tiltMax - @tiltMin
    # count picture-rows 
    @countRows = Math.ceil(@tiltArc/@pictureSize.height)
    # compute delta 
    @deltaTilt = @tiltArc/@countRows
    # create rows
    @rows = []
    for i in [0..@countRows]
      tilt = @tiltMin + i*@deltaTilt
      # create SphereRow
      @rows.push(new SphereRow(@, tilt))

###*
# one line in a sphere
# @memberOf threenorama
# @namespace SphereRow
###
module.exports.SphereRow =class SphereRow
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} tilt camera tilt in radians
  # @param {Object} pictureSize width/height in radians
  ###
  constructor: (@sphere, @tilt) ->
    # if top or bottom of sphere 
    if @tilt <= 0 or @tilt >= Math.PI
      @circumference = 0
      @countCols = 0
      @deltaPan = 0
      @cols = [
        new SphereCol(@tilt, 0, @sphere.pictureSize)
      ]
    else
      @circumference = Math.abs(Math.sin(@tilt))*@sphere.panArc
      @countCols = Math.ceil(@circumference/@sphere.pictureSize.width) 
      @deltaPan = @sphere.panArc/@countCols
      # generate cols
      @cols = []
      for i in [0..@countCols]
        pan = @sphere.panMin + i*@deltaPan
        @cols.push(new SphereCol(@tilt, pan, @sphere.pictureSize))

###*
# one cell in a sphere
# @memberOf threenorama
# @namespace SphereCol
###
module.exports.SphereCol = class SphereCol
  ###*
  # Constructor-Description
  ###
  constructor: (@tilt, @pan, @pictureSize) ->