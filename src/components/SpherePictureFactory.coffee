###*
# Description
# @memberOf threenorama
# @namespace SpherePictureFactory
###
class SpherePictureFactory
  ###*
  # @var {RecorderJob} recorderJob
  ###
  
  ###*
  # @var {Array<SpherePicture>} pictures
  ###
  
  ###*
  # Constructor-Description
  # @param {RecorderJob} recorderJob
  # @param {Number} recorderJob.tiltMin tilt position in rad 
  # @param {Number} recorderJob.tiltMax tilt position in rad
  # @param {Number} recorderJob.panMin pan position in rad
  # @param {Number} recorderJob.panMax pan position in rad
  # @param {Number} recorderJob.pictureWidth picture width in rad
  # @param {Number} recorderJob.pictureHeight pictureHeight in rad
  ###
  constructor: (@recorderJob) ->
    @pictures = []
    @_createRows()
 
  ###*
  # creates one or more rows 
  # computes tilt and applies it on _createCols to fill @pictures
  ###
  _createRows: ->
    # checks if height of segment could be covered by a single row
    tiltArc = @recorderJob.tiltMax-@recorderJob.tiltMin # = segment height
    if tiltArc < @recorderJob.pictureHeight
      # create cols for one row
      @_createCols(0, @recorderJob.tiltMin + tiltArc/2)
    # one picture isnt't enough to cover segment height
    else
      # the camera points to center of a picture so that our picture would 
      # capture beyound the borders
      # to cover only the desired area with pictures we have to redurce tiltArc by picture.tilt (height) 
      tiltArc -= @recorderJob.pictureHeight
      tiltStart = @recorderJob.tiltMin + @recorderJob.pictureHeight/2
      # count picture-rows regarding 50% overlapping
      countRows = Math.ceil(tiltArc/(@recorderJob.pictureHeight/2))
      # compute delta 
      deltaTilt = tiltArc/countRows
      # create cols for each row
      for i in [0..countRows]
        @_createCols(i, tiltStart + i*deltaTilt)
        
  ###*
  # @param {Number} row index of row
  # @param {Number} tilt camera tilt in radians
  ###
  _createCols: (row, tilt) ->
    # upwards the upper halfsphere and downwards the lower panArc decreases
    # in this relationsship we have to adjust image width to keep ansure right aspect ratio
    pictureWidth = @recorderJob.pictureWidth/Math.sin(tilt)
    panArc = @recorderJob.panMax-@recorderJob.panMin # = segment length
    # limit pictureWidth to 360°
    pictureWidth = Math.min(pictureWidth, 2*Math.PI)
    # if row could be covered by single image
    if panArc < pictureWidth
      @pictures.push( new SpherePicture(
        0
        row
        @recorderJob.panMin+panArc/2
        tilt
        pictureWidth
        @recorderJob.pictureHeight
      ))
    # if one image isnt enough to cover row
    else
      # the camera points to center of a picture
      # to cover only the desired area with pictures we have to redurce panArc by picture-pan (width) 
      panArc -=  pictureWidth
      panStart = @recorderJob.panMin + pictureWidth/2
      # count cols regarding 50% overlapping
      countCols = Math.ceil(panArc/(pictureWidth/2))
      deltaPan = panArc/countCols
      # generate cols
      for i in [0..countCols]
        @pictures.push( new SpherePicture(
          i
          row
          panStart + i*deltaPan
          tilt
          pictureWidth
          @recorderJob.pictureHeight
        ))

###*
# Description
# @memberOf threenorama
# @namespace ShpereTile
###
class SpherePicture
  ###*
  # @var {Number} x
  ###
  
  ###*
  # @var {Number} y
  ###
  
  ###*
  # @var {Number} pan
  ###
  
  ###*
  # @var {Number} tilt
  ###
  
  ###*
  # @var {Number} width
  ###

  ###*
  # @var {Number} height
  ###
  
  ###*
  # Constructor-Description
  # @var {Number} x
  # @var {Number} y
  # @var {Number} pan
  # @var {Number} tilt
  # @var {Number} width
  # @var {Number} height
  ###
  constructor: (@x, @y, @pan, @tilt, @width, @height) ->
  
###*
# exporting 
###
module.exports =
  SpherePictureFactory: SpherePictureFactory
  SpherePicture: SpherePicture