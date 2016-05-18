SphereSegmentCol = require('./SphereSegmentCol.coffee')

###*
# one line in a sphere
# @memberOf threenorama
# @namespace SphereSegmentRow
###
module.exports = class SphereSegmentRow
  ###*
  # Constructor-Description
  # @param {Object} segmentRect
  # @param {Number} tilt camera tilt in radians
  # @param {Object} pictureSize width/tilt in radians
  ###
  constructor: (@tilt, panSegment, pictureSize) ->    
    # upwards the upper halfsphere and downwards the lower panArc decreases
    # in this relationsship we have to adjust pan to keep ansure right aspect ratio    
    @pictureSize =
      tilt: pictureSize.tilt
      pan: pictureSize.pan/Math.sin(@tilt) 
    # the camera points to center of a picture
    # to cover only the desired area with pictures we have to redurce panArc by half of picture-tilt
    @panMin = panSegment.min + @pictureSize.pan/2
    @panMax = panSegment.max - @pictureSize.pan/2
    @panArc = @panMax - @panMin
    @countDeltaPan = Math.ceil(@panArc/@pictureSize.pan)
    # ensure horizontal overlapping of 50%
    @deltaPan = @panArc/@countDeltaPan
    while 0.5 > @pictureSize.pan-@deltaPan
      @deltaPan = @panArc/++@countDeltaPan
    # generate cols
    @cols = []
    for i in [0..@countDeltaPan]
      pan = @panMin + i*@deltaPan
      @cols.push(new SphereSegmentCol(@tilt, pan))