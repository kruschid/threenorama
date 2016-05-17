Sphere = require('./sphere.coffee')
fabric = require('../bower_components/fabric.js/dist/fabric.require.js')

fullSphereCamera =
  panMin: 0         # 0°
  panMax: 2*Math.PI # 306°
  tiltMin: 0        # 0°
  tiltMax: Math.PI  # 180°
pictureSize =
  width: Math.PI/4    # 45° =>  8*45° = 360°
  height: Math.PI/10  # 18° => 10*18° = 180° 
sphere = new Sphere(fullSphereCamera, pictureSize)

canvas = new fabric.StaticCanvas('c')
console.log canvas
rect = new fabric.Rect
  left: 100
  top: 100
  fill: 'red'
  width: 20
  height: 20
canvas.add(rect)