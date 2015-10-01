# Description:
#   Webqabot's internal behaviour
#

module.exports = (robot) ->

  room = if process.env.HUBOT_IRC_ROOMS then process.env.HUBOT_IRC_ROOMS.split ","[0] else "#mozwebqa"

  meeting = (time) ->
    time = if time != "" then time else "at 9am Pacific every Thursday"
    robot.messageRoom room, "Come join us #{time} for our team meeting!"
    robot.messageRoom room, "Meeting notes are available at https://wiki.mozilla.org/QA/Execution/Web_Testing#Meeting_Notes"
    vidyo()

  vidyo = () ->
    robot.messageRoom room, "Our Vidyo room is WebQA (8824)"
    robot.messageRoom room, "Public link: https://v.mozilla.com/flex.html?roomdirect.html&key=Tc08xVjMQmaVscjhN5jlm7mDknY"
    robot.messageRoom room, "Joining by phone: https://wiki.mozilla.org/Teleconferencing#Dialing_In"
    robot.messageRoom room, "For information on Vidyo: https://wiki.mozilla.org/Vidyo"

  # announce or provide details of our team meeting
  robot.respond /meeting\s*\b(.*)/i, (res) ->
    meeting res.match[1]

  # provide details of our team mission
  robot.respond /mission/i, (res) ->
    res.send "Our mission is to provide data, services and tools to positively impact the quality of Mozilla websites. " +
      "https://wiki.mozilla.org/QA/Execution/Web_Testing/Mission"

  # provide a link to team info
  robot.respond /team/i, (res) ->
    res.send "https://wiki.mozilla.org/QA/Execution/Web_Testing#Team_Members"

  # provide details of our vidyo room
  robot.respond /vidyo/i, (res) ->
    vidyo()

  robot.on "announceMeeting", (time) ->
    meeting time
