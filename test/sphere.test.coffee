chai.should()

chai.should()

describe 'Sphere', ->
  # create fictive cameratype 
  samplePTZCameraType = new SamplePTZCameraType()
  ptzCameraType = new PTZCameraType(samplePTZCameraType)
  
  beforeEach ->
   # do stuff
  afterEach ->
    # do stuff
    
  it '#rows should return correct number of rows', ->
    sphere0 = new Sphere(ptzCameraType, 0)
    console.log sphere0.rows()