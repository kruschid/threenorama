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
  # @var {Number} tiltArc arc length in radians
  # @var {Number} countDeltaTilt minimum number of pictures to cover tiltArc 
  # @var {Number} deltaTilt tilt distance between two pictures
  # @var {Array<SphereRow>} rows
  
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} zoom
  ###
  constructor: (@cameraType, @pictureSize) ->
    #init params
    {
      @panMin 
      @panMax
      @tiltMin
      @tiltMax
    } = @cameraType
    # tilt should have at least distance of half height of picture to both bottom an top of sphere not to cover area twice at the borders
    @tiltMin = Math.max(@tiltMin, @pictureSize.tilt/2)
    @tiltMax = Math.min(@tiltMax, Math.PI - @pictureSize.tilt/2)
    # compute vertical arc length
    @tiltArc = @tiltMax - @tiltMin
    # count picture-rows including 50% overlapping
    @countDeltaTilt = Math.ceil(@tiltArc/@pictureSize.tilt)*2 - 1
    # compute delta 
    @deltaTilt = @tiltArc/@countDeltaTilt
    # create rows
    @rows = []
    for i in [0..@countDeltaTilt]
      tilt = @tiltMin + i*@deltaTilt
      # create SphereRow
      @rows.push(new SphereRow(@, tilt))

###*
# one line in a sphere
# @memberOf threenorama
# @namespace SphereRow
###
module.exports.SphereRow = class SphereRow
  ###*
  # Constructor-Description
  # @param {PTZCameraType} cameraType
  # @param {Number} tilt camera tilt in radians
  # @param {Object} pictureSize width/tilt in radians
  ###
  constructor: (@sphere, @tilt) ->    
    # upwards the upper halfsphere and downwards the lower panArc decreases
    # so we have to adjust picture width to that decreasing panArc    
    @pictureSize =
      tilt: @sphere.pictureSize.tilt
      pan: @sphere.pictureSize.pan/Math.abs(Math.sin(@tilt)) 
    # pan should have at least distance of half picture-width to pan-origin (0°/360°) not to cover area at borders twice
    @panMin = Math.max(@sphere.panMin, @pictureSize.pan/2)
    @panMax = Math.min(@sphere.panMax, 2*Math.PI - @pictureSize.pan/2)
    @panArc = @panMax - @panMin
    @countDeltaPan = Math.ceil(@panArc/@pictureSize.pan)
    @deltaPan = @panArc/@countDeltaPan
    # ensure horizontal overlapping of 50%
    while 0.5 > 1-@deltaPan/@pictureSize.pan
      @deltaPan = @panArc/++@countDeltaPan
    # generate cols
    @cols = []
    for i in [0..@countDeltaPan]
      pan = @panMin + i*@deltaPan
      @cols.push(new SphereCol(@tilt, pan))

###*
# one cell in a sphere
# @memberOf threenorama
# @namespace SphereCol
###
module.exports.SphereCol = class SphereCol
  ###*
  # Constructor-Description
  ###
  constructor: (@tilt, @pan) ->