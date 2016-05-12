###*
# Represents PTZCamera 
# @memberOf threenorama
# @namespace PTZCamera
###
class PTZCameraType
  ###*
  # Constructor-Description
  ###
  constructor: ->
    @name = 'CAM1 Panasonic WV-SW598'
    @sensorWidth = 4.46 
    @sensorHeight = 7.93
    @focalLengthMin = 4.3
    @focalLengthMax = 387.0
    @devicePanMin = 0
    @devicePanMax = 1
    @devicePanAbsMin = 0
    @devicePanAbsMax = 1
    @deviceTiltMin = -0.972
    @deviceTiltMax = 0
    @deviceTiltAbsMin = 0.5
    @deviceTiltAbsMax = 1
    @deviceZoomMin = 0
    @deviceZoomMax = 0.083
  
  ### 
  TODO: Methods to implement
  deviceTilt(normalizedTilt: Number): Number
  devicePan(normalizedPan: Number): Number
  deviceZoom(normalizedZoom: Number): Number
  ###
  
  ###*
  # converts rad to normalized unit
  # @param {Number} rad angle in radiant
  # @return {Number}
  ###
  normalizeRad: (rad) -> 
    rad/(2*Math.PI)

  ###*
  # returns normalized picture size for zoom factor 1
  # @return {Object} normalized size
  ###  
  pictureSizeMin: ->
    w = 2*Math.atan(@sensorWidth/2 * 1/@focalLengthMax)/2
    h = 2*Math.atan(@sensorHeight/2 * 1/@focalLengthMax)/2
    return {
      width: @normalizeRad(w)
      height: @normalizeRad(h)
    }
  
  ###*
  # returns normalized picture size for zoom factor 2
  # @return {Object} normalized size
  ###  
  pictureSizeMax: ->
    w = 2*Math.atan(@sensorWidth/2 * 1/@focalLengthMin)/2
    h = 2*Math.atan(@sensorHeight/2 * 1/@focalLengthMin)/2
    return {
      width: @normalizeRad(w)
      height: @normalizeRad(h)
    }