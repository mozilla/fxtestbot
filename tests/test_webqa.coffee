Helper = require 'hubot-test-helper'
helper = new Helper('../scripts/webqa.coffee')
chai = require 'chai'
expect = chai.expect
PropertiesReader = require 'properties-reader'
properties = PropertiesReader('resources/responses.properties')
util = require('util') 

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
    it 'will respond to the announceMeeting event', ->
      time =  properties.get("cronTime")
      @room.robotEvent 'announceMeeting', time
      expectedMeetingResponse = [
        ['hubot', util.format(properties.get("time2"), time)]
        ['hubot', properties.get("time3")]
      ]
      expectedMeetingResponse.push hubotVidyoExpectedResponse...
      expect(@room.messages).to.eql expectedMeetingResponse

  context 'hubot responding to user messages', ->
    it 'will respond to meeting', ->
      expectedMeetingResponse = [
        ['shaggy', 'hubot meeting']
        ['hubot', util.format(properties.get("time2"), properties.get("time1"))]
        ['hubot', properties.get("time3")]
      ]
      expectedMeetingResponse.push hubotVidyoExpectedResponse...
      @room.user.say('shaggy', 'hubot meeting').then =>
        expect(@room.messages).to.eql expectedMeetingResponse

    it 'will respond to list', ->
      @room.user.say('scooby', 'hubot list').then =>
        expect(@room.messages).to.eql [
          ['scooby', 'hubot list']
          ['hubot', properties.get("list1")]
          ['hubot', properties.get("list2")]
          ['hubot', properties.get("list3")]
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

  