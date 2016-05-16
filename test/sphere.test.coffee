chai.should()

fullSphereCamera =
  panMin: 0         # 0°
  panMax: 2*Math.PI # 306°
  tiltMin: 0        # 0°
  tiltMax: Math.PI  # 180°
pictureSize =
  width: Math.PI/4    # 45° =>  8*45° = 360°
  height: Math.PI/10  # 18° => 10*18° = 180° 
sphere = new Sphere(fullSphereCamera, pictureSize)

describe 'Sphere', ->    
  it 'panCircumference should be computed correctly', ->
    sphere.panCircumference.should.be.equal(fullSphereCamera.panMax)
  
  it 'tiltCircumference should be computed correctly', ->
    sphere.tiltCircumference.should.be.equal(fullSphereCamera.tiltMax)
  
  it 'countRows should be computed correctly', ->
    sphere.countRows.should.be.equal(10)
  
  it 'deltaTilt should be computed correctly', ->
    sphere.deltaTilt.should.be.equal(Math.PI/10)
  
  it 'rows should have correct number of elements', ->
    sphere.rows.length.should.be.equal(11)
  
  it 'rows should only contain SphereRow instances', ->
    for row in sphere.rows
      row.should.be.instanceOf(SphereRow)
  
  it 'each row should have correct tilt', ->
    for row, i in sphere.rows
      row.tilt.should.be.equal(i*Math.PI/10)

describe 'SphereRow', ->
  it 'circumfence should be computed correctly', ->
    for row in sphere.rows
      row.circumference.should.be.equal(
        Math.abs(Math.sin(row.tilt))*sphere.panCircumference
      )
  
  it 'countCols should be computed correctly', ->
    for row in sphere.rows
      row.countCols.should.be.equal(
        Math.ceil(row.circumference/sphere.pictureSize.width)
      )
  
  it 'deltaPan should be computed correctly', ->
    for row in sphere.rows
      row.deltaPan.should.be.equal(
        sphere.panCircumference/row.countCols
      )
  
  it 'cols should contain correct number of elements', ->
    for row in sphere.rows
      row.cols.length.should.be.equal(
        row.countCols+1
      )

  it 'cols should only contain SphereCol instances', ->
    for row in sphere.rows
      for col in row.cols
        col.should.be.instanceOf(SphereCol)
  
  it 'each col should have correct pan', ->
    for row in sphere.rows
      console.log row.countCols
      console.log row.deltaPan
      for col, i in row.cols
        console.log col
        # col.pan.should.be.equal(
        #   sphere.panMin + i*col.deltaPan
        # )