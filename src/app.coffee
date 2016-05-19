SphereSegment = require('./components/sphereSegment/SphereSegment.coffee')
fabric = require('../bower_components/fabric.js/dist/fabric.require.js')

canvas = new fabric.Canvas('c')
canvas.setHeight(600)
      .setWidth(1200)

rectList = []

panSegment =
  min: Math.PI  # 0°
  max: 2*Math.PI    # 360°
tiltSegment =
  min: 0 # 90°
  max: Math.PI/2  # 180°
pictureSize =
  pan: Math.PI/4    # 45° =>  8*45° = 360°
  tilt: Math.PI/13.5  # 18° => 10*18° = 180° 
  
selection = new fabric.Rect
  left: 0
  top: 0
  height: 100
  width: 100
  fill: 'transparent'
  stroke: 'red'
  # centeredScaling: true
  #lockMovementX: true
  hasRotatingPoint: false
  lockScalingFlip: true
  #minScaleLimit: 

canvas.add(selection)

tiltToCanvas = (tilt) ->
  tilt/Math.PI*canvas.height
panToCanvas= (pan) ->
  pan/Math.PI/2*canvas.width
canvasToTilt = (top) -> 
  top/canvas.height*Math.PI
canvasToPan = (left) ->
  left/canvas.width*Math.PI*2
  
selection.on 'modified', ->
  canvas.remove(rectList.pop()) while rectList.length
  panSegment = 
    min: canvasToPan(@left)
    max: canvasToPan(@left+@width*@scaleX)
  tiltSegment = 
    min: canvasToTilt(@top)
    max: canvasToTilt(@top+@height*@scaleY)
  console.log panSegment, tiltSegment
  renderSphereSegment()
  @bringToFront()

renderSphereSegment = ->
  sphere = new SphereSegment(tiltSegment, panSegment, pictureSize)
  console.log 'picture tilt', pictureSize.tilt
  console.log 'deltaTilt', sphere.deltaTilt
  console.log 'überlappung', (pictureSize.tilt-sphere.deltaTilt)/pictureSize.tilt
  console.log 'rows', sphere.rows.length
  console.log 'countDeltaTilt', sphere.countDeltaTilt
  for row, i in sphere.rows
    for col in row.cols
      rect = new fabric.Rect
        hasControls: false
        selectable: false
        originX: 'center'
        originY: 'center'
        left: panToCanvas(col.pan)
        top: tiltToCanvas(col.tilt)
        height: tiltToCanvas(row.pictureSize.tilt)
        # width: panToCanvas(pictureSize.pan*2*Math.PI/row.panArc)
        width: panToCanvas(row.pictureSize.pan)
        fill: 'red'
        stroke: 'grey'
        opacity: 0.25
      rectList.push(rect)
      canvas.add(rect)