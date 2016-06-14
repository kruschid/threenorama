SpherePictureFactory = require('./components/SpherePictureFactory.coffee').SpherePictureFactory
Canvas = require('./components/Canvas.coffee')
fabric = require('fabric').fabric
THREE = require("three-js")()

pictureSize =
  width: Math.PI/3
  height: Math.PI/4

canvas = new Canvas('c')
canvas.setHeight(512)
      .setWidth(1024)
      .setBackgroundColor('white')
  
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

rectList = []
selection.on 'modified', ->
  # remove all rects
  canvas.remove(rectList.pop()) while rectList.length
  # define recorderjob
  sphere = new SpherePictureFactory
    tiltMin: canvas.toTilt(@top)
    tiltMax: canvas.toTilt(@top+@height*@scaleY)
    panMin: canvas.toPan(@left)
    panMax: canvas.toPan(@left+@width*@scaleX)
    pictureWidth: pictureSize.width
    pictureHeight: pictureSize.height
  # create rects
  console.log  sphere
  for pic in sphere.pictures
    rectList.push new fabric.Rect
      hasControls: false
      selectable: false
      originX: 'center'
      originY: 'center'
      left: canvas.fromPan(pic.pan)
      top: canvas.fromTilt(pic.tilt)
      width: canvas.fromPan(pic.width)
      height: canvas.fromTilt(pic.height)
      fill: 'red'
      stroke: 'grey'
      opacity: 0.25
  # bring selection to front
  canvas.add.apply(canvas, rectList)
  @bringToFront()
  

##
## THREE
## 
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(100, 1024/512, 0.1, 1000)

renderer = new THREE.WebGLRenderer()
renderer.setSize(1024, 512)
document.body.appendChild(renderer.domElement)

# light
light = new THREE.PointLight(0xffffff)
light.position.set(0,250,0)
scene.add(light)
  
##
radius = 100
segments = 32
rings = 32
geometry = new THREE.SphereGeometry(radius, segments, rings)
texture = new THREE.CanvasTexture(canvas.getElement())
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
  camera.rotation.y += 0.01
  # camera.rotation.x += 0.01
  renderer.render( scene, camera )

render()