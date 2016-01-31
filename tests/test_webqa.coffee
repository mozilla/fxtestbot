Helper = require 'hubot-test-helper'
helper = new Helper('../scripts/webqa.coffee')
chai = require 'chai'
sinon = require 'sinon'
expect = chai.expect
PropertiesReader = require 'properties-reader'
properties = PropertiesReader('resources/responses.properties')
util = require 'util'   
moment = require 'moment'
clock = null

describe 'webqa script', ->    
  hubotVidyoExpectedResponse = [
        [ 'hubot', properties.get("vidyo1")]
        [ 'hubot', properties.get("vidyo2")]
        [ 'hubot', properties.get("vidyo3")]
        [ 'hubot', properties.get("vidyo4")]
      ]

  beforeEach ->
    @room = helper.createRoom()
    clock = sinon.useFakeTimers(moment().valueOf());
    
  afterEach ->
    clock.restore()
    @room.destroy()

  context 'hubot responding to events', ->
    it 'will respond to the announceMeeting event', ->
      time =  properties.get("cronTime")
      clock = sinon.useFakeTimers(moment('2016-01-28').valueOf())
      @room.robotEvent 'announceMeeting', time
      expectedMeetingResponse = [
        ['hubot', util.format(properties.get("time2"), time)]
        ['hubot', util.format(properties.get("time3"), properties.get("time4"), '2016-01-28')]
      ]
      expectedMeetingResponse.push hubotVidyoExpectedResponse...
      expect(@room.messages).to.eql expectedMeetingResponse

  context 'hubot responding to user messages', ->
    it 'will respond to meeting when asked on a Thursday with today\'s meeting agenda', ->
      clock = sinon.useFakeTimers(moment('2016-01-28').valueOf())
      expectedMeetingResponse = [
        ['shaggy', 'hubot meeting']
        ['hubot', util.format(properties.get("time2"), properties.get("time1"))]
        ['hubot', util.format(properties.get("time3"), properties.get("time4"), '2016-01-28')]
      ]
      expectedMeetingResponse.push hubotVidyoExpectedResponse...
      @room.user.say('shaggy', 'hubot meeting').then =>
        expect(@room.messages).to.eql expectedMeetingResponse

    it 'will respond to meeting when asked about this week\'s meeting (i.e. Sunday - Wednesday)', ->
      clock = sinon.useFakeTimers(moment('2016-02-29').valueOf())
      expectedMeetingResponse = [
        ['shaggy', 'hubot meeting']
        ['hubot', util.format(properties.get("time2"), properties.get("time1"))]
        ['hubot', util.format(properties.get("time3"), properties.get("time5"), '2016-03-03')]
      ]
      expectedMeetingResponse.push hubotVidyoExpectedResponse...
      @room.user.say('shaggy', 'hubot meeting').then =>
        expect(@room.messages).to.eql expectedMeetingResponse   

    it 'will respond to meeting when asked about next week\'s meeting (i.e. asked on Friday or Saturday)', ->
      clock = sinon.useFakeTimers(moment('2016-12-31').valueOf())
      expectedMeetingResponse = [
        ['shaggy', 'hubot meeting']
        ['hubot', util.format(properties.get("time2"), properties.get("time1"))]
        ['hubot', util.format(properties.get("time3"), properties.get("time5"), '2017-01-05')]
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

  