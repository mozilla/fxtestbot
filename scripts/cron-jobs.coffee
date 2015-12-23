# Description:
#   Sets up cron jobs for webqabot.
#

PropertiesReader = require 'properties-reader'
properties = PropertiesReader('resources/responses.properties')

module.exports = (robot) ->

  announceMeeting = () ->
    robot.emit "announceMeeting", properties.get("cronTime")

  tz = "America/Los_Angeles"
  cronJob = require("cron").CronJob
  new cronJob("45 8 * * 4", announceMeeting, null, true, tz)
