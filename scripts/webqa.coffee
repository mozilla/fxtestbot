# Description:
#   Webqabot's internal behaviour
#

module.exports = (robot) ->

  meeting = (res, howSoon) ->
    if howSoon.length
      meetingTime = howSoon
    else
      meetingTime = " at 9AM Pacific every Thursday"
    res.send "Come join us#{meetingTime} for our team meeting!"
    res.send "Meeting notes are available at https://wiki.mozilla.org/QA/Execution/Web_Testing#Meeting_Notes"
    vidyo res

  vidyo = (res) ->
    res.send "Our Vidyo room is WebQA (8824)"
    res.send "Public link: https://v.mozilla.com/flex.html?roomdirect.html&key=Tc08xVjMQmaVscjhN5jlm7mDknY"
    res.send "Joining by phone: https://wiki.mozilla.org/Teleconferencing#Dialing_In"
    res.send "For information on Vidyo: https://wiki.mozilla.org/Vidyo"

  # announce or provide details of our team meeting
  robot.respond /meeting(\s+(.*)|)/i, (res) ->
    meeting res, res.match[1]

  # provide details of our team mission
  robot.respond /mission/i, (res) ->
    res.send "Our mission is to provide data, services and tools to positively impact the quality of Mozilla websites. " +
      "https://wiki.mozilla.org/QA/Execution/Web_Testing/Mission"

  # provide a link to team info
  robot.respond /team/i, (res) ->
    res.send "https://wiki.mozilla.org/QA/Execution/Web_Testing#Team_Members"

  # provide details of our vidyo room
  robot.respond /vidyo/i, (res) ->
    vidyo res
