###*
# Represents PTZCamera 
# @memberOf threenorama
# @namespace PTZCamera
###
module.exports = class PTZCameraType
  ###*
  # Constructor-Description
  # @param {Object} conf Configuration 
  # @param {String} conf.name Name of Camera
  # @param {Number} conf.sensorWidth Width of sensor in mm
  # @param {Number} conf.sensorHeight Height of sensor in mm
  # ...
  ###
  constructor: (conf) -> 
    {
      @name
      @sensorWidth 
      @sensorHeight 
      @focalLengthMin
      @focalLengthMax 
      @devicePanMin
      @devicePanMax
      @deviceTiltMin
      @deviceTiltMax
      @deviceZoomMin
      @deviceZoomMax
      @panMin 
      @panMax
      @tiltMin
      @tiltMax
    } = conf
  
  ###*
  # returns picture size for provided zoom factor
  # source: http://www.vision-doctor.de/optische-grundlagen.html
  # @param {Number} zoom Zoom-facor with valid range of [0,1]
  # @return {Object} size in rad (width/height)
  ###
  pictureSize: (zoom) ->
    focalLength = @focalLengthMin + zoom*(@focalLengthMax-@focalLengthMin)
    w = Math.atan(@sensorWidth/2 * 1/focalLength)
    h = Math.atan(@sensorHeight/2 * 1/focalLength)
    return {
      width: w
      height: h
    }
 
  ### 
  TODO: Methods to implement
  deviceTilt(normalizedTilt: Number): Number
  devicePan(normalizedPan: Number): Number
  deviceZoom(normalizedZoom: Number): Number
  ###

  # ###*
  # # converts rad to normalized unit
  # # @param {Number} rad angle in radiant
  # # @return {Number} normalized angle
  # ###
  # normalizeRad: (rad) -> 
  #   rad/(2*Math.PI)
  
  
  # ###*
  # # returns picture size for zoom factor 1
  # # @return {Object} size in rad (width/height)
  # ###  
  # pictureSizeMin: ->
  #   w = 2*Math.atan(@sensorWidth/2 * 1/@focalLengthMax)/2
  #   h = 2*Math.atan(@sensorHeight/2 * 1/@focalLengthMax)/2
  #   return {
  #     width: w
  #     height: h
  #   }
  
  # ###*
  # # returns normalized picture size for zoom factor 2
  # # @return {Object} normalized size (width/height)
  # ###  
  # pictureSizeMax: ->
  #   w = 2*Math.atan(@sensorWidth/2 * 1/@focalLengthMin)/2
  #   h = 2*Math.atan(@sensorHeight/2 * 1/@focalLengthMin)/2
  #   return {
  #     width: w
  #     height: h
  #   }