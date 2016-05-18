threenorama = require('../src/sphere.coffee')

chai.should()

fullSphereCamera =
  panMin: 0         # 0°
  panMax: 2*Math.PI # 360°
  tiltMin: 0        # 0°
  tiltMax: Math.PI  # 180°
pictureSize =
  pan: Math.PI/4    # 45° =>  8*45° = 360°
  tilt: Math.PI/10  # 18° => 10*18° = 180° 
sphere = new threenorama.Sphere(fullSphereCamera, pictureSize)

describe 'Sphere', -> 
  it 'tiltMin should be computed correctly', ->
    sphere.tiltMin.should.be.equal(
      fullSphereCamera.tiltMin+pictureSize.tilt/2
    )
    
  it 'tiltMax should be computed correctly', ->   
    sphere.tiltMax.should.be.equal(
      fullSphereCamera.tiltMax-pictureSize.tilt/2
    )
    
  it 'panArc should be computed correctly', ->
    sphere.panArc.should.be.approximately(
      fullSphereCamera.panMax-pictureSize.pan
      0.00000000001
    )
  
  it 'tiltArc should be computed correctly', ->
    sphere.tiltArc.should.be.equal(
      fullSphereCamera.tiltMax-pictureSize.tilt
    )
  
  it 'countDeltaTilt should be computed correctly', ->
    # because the algorithm doesn't cover top and bottom of sphere we lose here one line 
    sphere.countDeltaTilt.should.be.equal(9) 
  
  it 'deltaTilt should be computed correctly', ->
    sphere.deltaTilt.should.be.equal(sphere.tiltArc/9)
  
  it 'rows should have correct number of elements', ->
    sphere.rows.length.should.be.equal(
      sphere.countDeltaTilt+1
    )
  
  it 'rows should only contain SphereRow instances', ->
    for row in sphere.rows
      row.should.be.instanceOf(threenorama.SphereRow)
  
  it 'each row should have correct tilt', ->
    for row, i in sphere.rows
      row.tilt.should.be.equal(
        sphere.tiltMin + i*sphere.deltaTilt
      )

describe 'SphereRow', ->
  it 'panArc should be computed correctly', ->
    for row in sphere.rows
      row.panArc.should.be.equal(
        Math.abs(Math.sin(row.tilt))*sphere.panArc
      )
  
  it 'countDeltaPan should be computed correctly', ->
    for row in sphere.rows
      row.countDeltaPan.should.be.equal(
        Math.ceil(row.panArc/sphere.pictureSize.pan)
      )
  
  it 'deltaPan should be computed correctly', ->
    for row in sphere.rows
      if row.tilt <= 0 or row.tilt >= Math.PI
        row.deltaPan.should.be.equal(0)
      else
        row.deltaPan.should.be.equal(
          sphere.panArc/row.countDeltaPan
        )
        
  it 'cols should contain correct number of elements', ->
    for row in sphere.rows
      row.cols.length.should.be.equal(
        row.countDeltaPan+1
      )

  it 'cols should only contain SphereCol instances', ->
    for row in sphere.rows
      for col in row.cols
        col.should.be.instanceOf(threenorama.SphereCol)

  it 'each col should have correct tilt', ->
    for row, k in sphere.rows
      for col in row.cols
        col.tilt.should.be.equal(
          sphere.tiltMin + k*sphere.deltaTilt
        )
  
  it 'each col should have correct pan', ->
    for row in sphere.rows
      for col, i in row.cols
        col.pan.should.be.equal(
          sphere.panMin + i*row.deltaPan
        )