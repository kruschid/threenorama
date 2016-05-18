SphereSegmentRow = require('./SphereSegmentRow.coffee')

###*
# Description
# @memberOf threenorama
# @namespace SphereSegement
###
module.exports = class SphereSegment
  # @var {Number} panMin pan arc start point in radians
  # @var {Number} panMax pan arc end point in radians
  # @var {Number} tilMin tilt arc start point in radians
  # @var {Number} tilMax tilt arc end point in radians
  # @var {Number} tiltArc arc length in radians
  # @var {Number} countDeltaTilt minimum number of pictures to cover tiltArc 
  # @var {Number} deltaTilt tilt distance between two pictures
  # @var {Array<SphereSegmentRow>} rows
  
  ###*
  # Constructor-Description
  # @param {Object} segmentRect
  # @param {Number} tiltSegment.min
  # @param {Number} tiltSegment.max
  # @param {Number} panSegment.min
  # @param {Number} panSegment.max
  # @param {Object} pictureSize
  # @param {Number} pictureSize.tilt
  # @param {Number} pictureSize.pan
  ###
  constructor: (tiltSegment, panSegment, pictureSize) ->
    # the camera points to center of a picture
    # to cover only the desired area with pictures we have to redurce tiltArc by half of picture-tilt 
    @tiltMin = tiltSegment.min+pictureSize.tilt/2
    @tiltMax = tiltSegment.max-pictureSize.tilt/2
    # compute length of tiltArc
    @tiltArc = @tiltMax - @tiltMin
    # count picture-rows regarding 50% overlapping
    @countDeltaTilt = Math.ceil(@tiltArc/pictureSize.tilt)*2 - 1
    # compute delta 
    @deltaTilt = @tiltArc/@countDeltaTilt
    # create rows
    @rows = []
    for i in [0..@countDeltaTilt]
      tilt = @tiltMin + i*@deltaTilt
      # create SphereSegmentRow
      @rows.push(new SphereSegmentRow(tilt, panSegment, pictureSize))