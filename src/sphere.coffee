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
  constructor: (cameraType, @pictureSize) ->
    #init params
    {
      @panMin 
      @panMax
      @tiltMin
      @tiltMax
    } = cameraType
    # compute horizontal circumference
    @panCircumference = @panMax - @panMin
    # compute vertical circumference
    @tiltCircumference = @tiltMax - @tiltMin
    # count picture-rows 
    @countRows = Math.ceil(@tiltCircumference/@pictureSize.height)
    # compute delta 
    @deltaTilt = @tiltCircumference/@countRows
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
class SphereRow
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} tilt camera tilt in radians
  # @param {Object} pictureSize width/height in radians
  ###
  constructor: (@sphere, @tilt) ->
    @circumference = Math.abs(Math.sin(@tilt))*@sphere.panCircumference
    @countCols = Math.ceil(@circumference/@sphere.pictureSize.width)
    @deltaPan = @sphere.panCircumference/@countCols
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
class SphereCol
  ###*
  # Constructor-Description
  ###
  constructor: (@tilt, @pan, @pictureSize) ->
    