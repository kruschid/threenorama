threenorama = require('../src/components/SpherePictureFactory.coffee')
SpherePictureFactory = threenorama.SpherePictureFactory
SpherePicture = threenorama.SpherePicture

chai.should()

describe 'SpherePictureFactory', ->
  describe '#pictures', ->
    it 'should only contain SpherePicture instances', ->
      # full sphere recorderjob
      rj =
        tiltMin: 0
        tiltMax: Math.PI 
        panMin: 0
        panMax: 2*Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      for pic in pictures
        pic.should.be.instanceOf(SpherePicture)
      
    it 'should contain 1 element when pictureSize covers tiltArc and panArc completely', ->
      rj =
        tiltMin: Math.PI/2
        tiltMax: Math.PI/2
        panMin: Math.PI
        panMax: Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      pictures.length.should.be.equal(1)
      
    it 'should constist of 1 row but many cols when pictureHeight>tiltArc', ->
      rj =
        tiltMin: Math.PI/2 # sin(Math.PI/2) = 1
        tiltMax: Math.PI/2
        panMin: 0
        panMax: Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      # only one row
      for pic in pictures
        pic.y.should.be.equal(0)
      # sin(Math.PI/2) = 1 
      # => pictureWidth = pictureWidth/sin(Math.PI/2) 
      # => countPictures = pictureWidth / (panMax-panMin) = 4
      # => countPictures + 3 in between to ensure overlapping = 7 pictures 
      pictures.length.should.be.equal(7)
    
    it 'should constist of 1 col but many rows when pictureWidth>panArc', -> 
      rj =
        tiltMin: Math.PI/2
        tiltMax: Math.PI
        panMin: Math.PI
        panMax: Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      # only one row
      for pic in pictures
        pic.x.should.be.equal(0)
      # 5 rows (5 rows + 4 in between to ensure overlapping)
      pictures.length.should.be.equal(9)   
  
    it 'should contain picture with width of 360° when tilt is 0', ->
      rj =
        tiltMin: 0
        tiltMax: 0
        panMin: Math.PI
        panMax: Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      # first picture and last picture
      pictures[0].width.should.be.equal(2*Math.PI)
      
    it 'should have overlapping of 50%', ->
      # fullspehre recorderjob
      rj =
        tiltMin: 0
        tiltMax: Math.PI 
        panMin: 0
        panMax: 2*Math.PI
        pictureWidth: Math.PI/4
        pictureHeight: Math.PI/10
      pictures = new SpherePictureFactory(rj).pictures
      lastPic = undefined
      for pic in pictures
        # same row
        if lastPic?.y is pic.y
          # should at least cover 50% of prevoius picture horizontally
          pic.pan.should.be.at.most(lastPic.pan+pic.width/2)
        # next row
        else if lastPic?.y < pic.y
          # should at least cover 50% of prevoius picture vertically
          pic.tilt.should.be.at.most(lastPic.tilt+pic.height/2)
        # remember curr pic for next iteration
        lastPic = pic