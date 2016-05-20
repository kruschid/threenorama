SphereSegment = require('./components/sphereSegment/SphereSegment.coffee')
fabric = require('../bower_components/fabric.js/dist/fabric.require.js')
THREE = require("three-js")()

canvas = new fabric.Canvas('c')
canvas.setHeight(512)
      .setWidth(1024)
      .setBackgroundColor('white')

rectList = []

panSegment =
  min: Math.PI  # 0°
  max: 2*Math.PI    # 360°
tiltSegment =
  min: 0 # 90°
  max: Math.PI/2  # 180°
pictureSize =
  pan: Math.PI/4    # 45° =>  8*45° = 360°
  tilt: Math.PI/8  # 18° => 10*18° = 180° 
  
selection = new fabric.Rect
  left: 250
  top: 125
  height: 250
  width: 500
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

##
## THREE
## 
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(70, 1200/600, 0.1, 1000)

renderer = new THREE.WebGLRenderer()
renderer.setSize(1200, 600)
document.body.appendChild(renderer.domElement)

# light
light = new THREE.PointLight(0xffffff)
light.position.set(0,250,0)
scene.add(light)
  
##
radius = 100
segments = 16
rings = 16
geometry = new THREE.SphereGeometry(radius, segments, rings)
texture = new THREE.CanvasTexture(document.getElementById('c'))
material = new THREE.MeshBasicMaterial
  map: texture
  side: THREE.BackSide
  
sphere = new THREE.Mesh(geometry, material)
scene.add(sphere)

# console.log canvas.lowerCanvasEl
# camera.position.z = 5

render = ->
  requestAnimationFrame( render )
  texture.needsUpdate = true
  # camera.rotation.y += 0.01
  renderer.render( scene, camera )

render()