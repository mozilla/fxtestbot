# Description:
#   Sets up cron jobs for webqabot.
#

module.exports = (robot) ->

  announceMeeting = () ->
    robot.emit "announceMeeting", "in 15 minutes"

  tz = "America/Los_Angeles"
  cronJob = require("cron").CronJob
  new cronJob("45 8 * * 4", announceMeeting, null, true, tz)
