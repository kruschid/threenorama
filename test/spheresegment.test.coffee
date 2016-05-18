SphereSegment = require('../src/components/sphereSegment/SphereSegment.coffee')
SphereSegmentRow = require('../src/components/sphereSegment/SphereSegmentRow.coffee')
SphereSegmentCol = require('../src/components/sphereSegment/SphereSegmentCol.coffee')

chai.should()

tiltSegment = 
  min: 0        # 0°
  max: Math.PI  # 180°
panSegment = 
  min: 0         # 0°
  max: 2*Math.PI # 360°
pictureSize =
  pan: Math.PI/4    # 45° =>  8*45° = 360°
  tilt: Math.PI/10  # 18° => 10*18° = 180°
   
sphere = new SphereSegment(tiltSegment, panSegment, pictureSize)

describe 'SphereSegment', -> 
  it 'tiltMin should be computed correctly', ->
    sphere.tiltMin.should.be.equal(
      tiltSegment.min+pictureSize.tilt/2
    )
    
  it 'tiltMax should be computed correctly', ->   
    sphere.tiltMax.should.be.equal(
      tiltSegment.max-pictureSize.tilt/2
    )
    
  it 'tiltArc should be computed correctly', ->
    sphere.tiltArc.should.be.equal(
      tiltSegment.max-pictureSize.tilt
    )
  
  it 'countDeltaTilt should be computed correctly', ->
    # because the algorithm doesn't cover top and bottom of sphere we lose here one line 
    # we also have overlapping lines between the rows
    sphere.countDeltaTilt.should.be.equal(9 + 8)  #17
  
  it 'deltaTilt should be computed correctly', ->
    sphere.deltaTilt.should.be.equal(sphere.tiltArc/17)
  
  it 'rows should have correct number of elements', ->
    sphere.rows.length.should.be.equal(
      sphere.countDeltaTilt+1
    )
  
  it 'rows should only contain SphereRow instances', ->
    for row in sphere.rows
      row.should.be.instanceOf(SphereSegmentRow)
  
  it 'each row should have correct tilt', ->
    for row, i in sphere.rows
      row.tilt.should.be.equal(
        sphere.tiltMin + i*sphere.deltaTilt
      )

describe 'SphereSegmentRow', ->
  it 'pictureSize should be cumputed correctly', ->
    for row in sphere.rows
      row.pictureSize.tilt.should.be.equal(pictureSize.tilt)
      row.pictureSize.pan.should.be.equal(
        pictureSize.pan/Math.sin(row.tilt)
      )
      
  it 'panMin should be computed correctly', ->
    for row in sphere.rows
      row.panMin.should.be.equal(
        panSegment.min + row.pictureSize.pan/2
      )

  it 'panMax should be computed correctly', ->
    for row in sphere.rows
      row.panMax.should.be.equal(
        panSegment.max - row.pictureSize.pan/2
      )
  
  it 'panArc should be computed correctly', ->
    for row in sphere.rows
      row.panArc.should.be.equal(
        row.panMax - row.panMin
      )
  
  it 'deltaPan should ensure overlapping of 50%', ->
    for row in sphere.rows
      (0.5 > row.pictureSize.pan-row.deltaPan).should.be.false
        
  it 'cols should contain correct number of elements', ->
    for row in sphere.rows
      row.cols.length.should.be.equal(
        row.countDeltaPan+1
      )

  it 'cols should only contain SphereCol instances', ->
    for row in sphere.rows
      for col in row.cols
        col.should.be.instanceOf(SphereSegmentCol)

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
          row.panMin + i*row.deltaPan
        )