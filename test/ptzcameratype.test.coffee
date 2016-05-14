chai.should()

describe 'PTZCameraType', ->
  # create fictive cameratype 
  samplePTZCameraType = new SamplePTZCameraType()
  ptzCameraType = new PTZCameraType(samplePTZCameraType)
  
  beforeEach ->
   # do stuff
  afterEach ->
    # do stuff
  
  it '#pictureSize should return correct width and height', ->
    for referenceSize, i in samplePTZCameraType.pictureSizeList
      size = ptzCameraType.pictureSize(i/10)
      should.exist(size.width)
      size.width.should.be.approximately(referenceSize.width, 0.00001)
      should.exist(size.height)
      size.height.should.be.approximately(referenceSize.height, 0.00001)      