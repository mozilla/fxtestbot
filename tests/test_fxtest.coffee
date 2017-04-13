Helper = require 'hubot-test-helper'
helper = new Helper('../scripts/fxtest.coffee')
chai = require 'chai'
sinon = require 'sinon'
expect = chai.expect
PropertiesReader = require 'properties-reader'
properties = PropertiesReader('resources/responses.properties')
util = require 'util'

describe 'webqa script', ->
  hubotVidyoExpectedResponse = [
        [ 'hubot', properties.get("vidyo1")]
        [ 'hubot', properties.get("vidyo2")]
        [ 'hubot', properties.get("vidyo3")]
        [ 'hubot', properties.get("vidyo4")]
      ]

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  context 'hubot responding to events', ->
    it 'will respond to the announceEvent event', ->
      time = 'in 15 minutes'
      @room.robotEvent 'announceEvent', time, 'my event'
      expectedEventResponse = [
        ['hubot', util.format(properties.get("event"), time, 'my event')]
      ]
      expectedEventResponse.push hubotVidyoExpectedResponse...
      expect(@room.messages).to.eql expectedEventResponse

  context 'hubot responding to user messages', ->
    it 'will respond to list', ->
      @room.user.say('scooby', 'hubot list').then =>
        expect(@room.messages).to.eql [
          ['scooby', 'hubot list']
          ['hubot', properties.get("list1")]
          ['hubot', properties.get("list2")]
        ]

    it 'will respond to mission', ->
      @room.user.say('fred', 'hubot mission').then =>
        expect(@room.messages).to.eql [
          ['fred', 'hubot mission']
          ['hubot', properties.get("mission")]
        ]

    it 'will respond to source', ->
      @room.user.say('barney', 'hubot source').then =>
        expect(@room.messages).to.eql [
          ['barney', 'hubot source']
          ['hubot', properties.get("source")]
        ]

    it 'will respond to team', ->
      @room.user.say('wilma', 'hubot team').then =>
        expect(@room.messages).to.eql [
          ['wilma', 'hubot team']
          ['hubot', properties.get("team")]
        ]

    it 'will respond to vidyo', ->
      expectedVidyoResult = [['betty', 'hubot vidyo']]
      expectedVidyoResult.push hubotVidyoExpectedResponse...
      @room.user.say('betty', 'hubot vidyo').then =>
        expect(@room.messages).to.eql expectedVidyoResult
