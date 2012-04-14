chai = require 'chai'
chai.should()

{RetinaImage} = require '../src/retina_image'
{RetinaImagePath} = require '../src/retina_image_path'

describe 'RetinaImagePath instance', ->
  path = null 

  it 'should be external if image path references a remote domain with www', ->
    RetinaImagePath.domain = "www.apple.com"
    path = new RetinaImagePath("http://www.google.com/images/some_image.png")
    path.is_external().should.equal true


  it 'should be external if image path references a remote domain without www', ->
    RetinaImagePath.domain = "www.apple.com"
    path = new RetinaImagePath("http://google.com/images/some_image.png")
    path.is_external().should.equal true

    
  it 'should be external if image path is a remote domain with www and domain is localhost', ->
    RetinaImagePath.domain = "localhost"
    path = new RetinaImagePath("http://www.google.com/images/some_image.png")
    path.is_external().should.equal true


  it 'should be external if image path is a remote domain without www and domain is localhost', ->
    RetinaImagePath.domain = "localhost"
    path = new RetinaImagePath("http://google.com/images/some_image.png")
    path.is_external().should.equal true
    

  it 'should not be external if image path is relative with www', ->
    RetinaImagePath.domain = "www.apple.com"
    path = new RetinaImagePath("/images/some_image.png")
    path.is_external().should.equal false


  it 'should not be external if image path is relative without www', ->
    RetinaImagePath.domain = "apple.com"
    path = new RetinaImagePath("/images/some_image.png")
    path.is_external().should.equal false
    
    
  it 'should not be external if image path is relative to localhost', ->
    RetinaImagePath.domain = "localhost"
    path = new RetinaImagePath("/images/some_image.png")
    path.is_external().should.equal false

    
  it 'should not be external if image path has same domain as current site with www', ->
    RetinaImagePath.domain = "www.apple.com"
    path = new RetinaImagePath("http://www.apple.com/images/some_image.png")
    path.is_external().should.equal false    
    
    
  it 'should not be external if image path has www and domain does not', ->
    RetinaImagePath.domain = "apple.com"
    path = new RetinaImagePath("http://www.apple.com/images/some_image.png")
    path.is_external().should.equal false    
    

  it 'should not be external if image path does not have www and domain does', ->
    RetinaImagePath.domain = "www.apple.com"
    path = new RetinaImagePath("http://apple.com/images/some_image.png")
    path.is_external().should.equal false