###*
# Sample PTZ-CameraConfig Panasonic WV-SW598
# @memberOf threenorama.test
# @namespace SamplePTZCameraType
###
class SamplePTZCameraType
  ###*
  # inits cameratype 
  ###
  constructor: ->
    @name = 'Panasonic WV-SW598'
    @sensorWidth = 7.93
    @sensorHeight = 4.46
    @focalLengthMin = 4.3
    @focalLengthMax = 387.0
    @devicePanMin = 0
    @devicePanMax = 1
    @deviceTiltMin = -0.972
    @deviceTiltMax = 0
    @deviceZoomMin = 0
    @deviceZoomMax = 0.083
    @panFrom = 0 # 0°
    @panTo = Math.PI*2 # 360°
    @tiltFrom = Math.PI/2 # 90°
    @tiltTo = Math.PI # 180°
    # picture sizes cover full zoom range of 0 to 1
    @pictureSizeList = [
      {width: 0.7448879726520004, height:0.4784203108246571}
      {width: 0.0928727648872172, height:0.05233647073487066}
      {width: 0.04900822741466041, height: 0.02757835993714685}
      {width: 0.03327626897098891, height: 0.018720002529591315}
      {width: 0.025188470079966295, height: 0.01416857780454378}
      {width: 0.02026300701636162, height: 0.011397410883920944}
      {width: 0.01694861634996136, height: 0.009532884954293714}
      {width: 0.014566000147632282, height: 0.00819262319677842}
      {width: 0.01277067721052659, height: 0.007182766378006881}
      {width: 0.01136933776119369, height: 0.006394544790715413}
      {width: 0.010245119570089906, height: 0.005762210126614937}
    ]