Helper = require('hubot-test-helper')
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

helper = new Helper('../src/velib.coffee')

describe 'velib', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/velib')(@robot)

  it 'finds velibs', ->
    @room.user.say('alice', '@hubot velibs in raspail').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot velibs in raspail']
        ['hubot', '@alice No near stations']
      ]

  it 'finds no stations', ->
    expect(@robot.respond).to.have.been.calledWith(/hello/)
    
#expect(@robot.respond).to.have.been.calledWith(/velibs in (.*)/i)
