# Description:
#   Sets up cron jobs for webqabot.
#

# PropertiesReader = require 'properties-reader'
# properties = PropertiesReader('resources/responses.properties')
#
# module.exports = (robot) ->
#
#   cronJob = require("cron").CronJob
#
#   event = () ->
#     if new Date().getDate() < 7
#       robot.emit 'announceEvent', 'in 15 minutes', 'Automationeers Assemble'
#
#   new cronJob('45 12 * * 3', event, null, true, 'America/Los_Angeles')
