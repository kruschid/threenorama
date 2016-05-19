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
    # in this relationsship we have to adjust image width to keep ansure right aspect ratio    
    @pictureSize =
      tilt: pictureSize.tilt
      pan: pictureSize.pan/Math.sin(@tilt) 
    @panArc = panSegment.max-panSegment.min # = segment width
    # if row could be covered by single image
    if @panArc < @pictureSize.pan
      @cols = [new SphereSegmentCol(
        @tilt
        panSegment.min + @panArc/2
      )]
    # if one image isnt enough to cover row
    else
      # the camera points to center of a picture
      # to cover only the desired area with pictures we have to redurce panArc by picture-pan (width) 
      @panArc -=  @pictureSize.pan
      @panStart = panSegment.min + @pictureSize.pan/2
      # count cols regarding 50% overlapping
      @countDeltaPan = Math.ceil(@panArc/(@pictureSize.pan/2))
      @deltaPan = @panArc/@countDeltaPan
      # generate cols
      @cols = []
      for i in [0..@countDeltaPan]
        pan = @panStart + i*@deltaPan
        @cols.push(new SphereSegmentCol(@tilt, pan))