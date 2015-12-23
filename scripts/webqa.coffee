# Description:
#   Webqabot's internal behaviour
util = require 'util' 
PropertiesReader = require 'properties-reader'
properties = PropertiesReader('resources/responses.properties')
module.exports = (robot) ->

  room = if process.env.HUBOT_IRC_ROOMS then process.env.HUBOT_IRC_ROOMS.split ","[0] else "#mozwebqa"

  meeting = (time) ->
    time = if time != "" then time else properties.get("time1")
    robot.messageRoom room, util.format(properties.get("time2"), time)
    robot.messageRoom room, properties.get("time3")
    vidyo()

  vidyo = () ->
    robot.messageRoom room, properties.get("vidyo1")
    robot.messageRoom room, properties.get("vidyo2")
    robot.messageRoom room, properties.get("vidyo3")
    robot.messageRoom room, properties.get("vidyo4")

  # provide details about our mailing list
  robot.respond /list/i, (res) ->
    res.send properties.get("list1")
    res.send properties.get("list2")
    res.send properties.get("list3")

  # announce or provide details of our team meeting
  robot.respond /meeting\s*\b(.*)/i, (res) ->
    meeting res.match[1]

  # provide details of our team mission
  robot.respond /mission/i, (res) ->
    res.send properties.get("mission")

  # provide details about webqabot's source code
  robot.respond /source/i, (res) ->
    res.send properties.get("source")

  # provide a link to team info
  robot.respond /team/i, (res) ->
    res.send properties.get("team")

  # provide details of our vidyo room
  robot.respond /vidyo/i, (res) ->
    vidyo()

  robot.on "announceMeeting", (time) ->
    meeting time
