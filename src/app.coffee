SphereSegment = require('./components/sphereSegment/SphereSegment.coffee')
fabric = require('../bower_components/fabric.js/dist/fabric.require.js')

panSegment =
  min: 1.5*Math.PI   # 0°
  max: 2*Math.PI # 306°
tiltSegment =
  min: 0 # 90°
  max: Math.PI  # 180°
pictureSize =
  pan: Math.PI/4    # 45° =>  8*45° = 360°
  tilt: Math.PI/10  # 18° => 10*18° = 180° 
sphere = new SphereSegment(tiltSegment, panSegment, pictureSize)
canvas = new fabric.StaticCanvas('c')
canvas.setHeight(600)
      .setWidth(1400)

tiltToCanvas = (tilt) ->
  tilt/Math.PI*canvas.height
panToCanvas= (pan) ->
  pan/Math.PI/2*(canvas.width-200)

for row, i in sphere.rows
  for col in row.cols
    canvas.add new fabric.Rect
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
  
# rect = new fabric.Rect
#   left: 100
#   top: 100
#   fill: 'red'
#   width: 20
#   height: 20
# canvas.add(rect)