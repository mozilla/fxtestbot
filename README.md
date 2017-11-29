# fxtestbot

[![license](https://img.shields.io/badge/license-MPL%202.0-blue.svg)](https://github.com/mozilla/fxtestbot/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/mozilla/fxtestbot.svg?branch=master)](https://travis-ci.org/mozilla/fxtestbot)

fxtestbot is a chat bot built on the [Hubot][hubot] framework for use in the [#fx-test IRC channel][irc].

[hubot]: http://hubot.github.com
[irc]: http://chat.mibbit.com/?server=irc.mozilla.org%3A%2B6697&channel=%23fx-test


## Running fxtestbot Locally

You can test fxtestbot by running the `hubot` command in the `bin` folder:

    % bin/hubot

fxtestbot expects at least the `HUBOT_BUGZILLA_URL` environment variable to exist,
so you can either set that in your environment,
or you can run the command setting that variable explicitly:

    % HUBOT_BUGZILLA_URL=https://bugzilla.mozilla.org bin/hubot

You'll see some start up output and a prompt:

    [Tue Oct 06 2015 10:58:42 GMT-0400 (EDT)] INFO hubot-redis-brain: Using default redis on localhost:6379
    fxtestbot>

Then you can interact with fxtestbot by typing `fxtestbot help`.

    fxtestbot> fxtestbot help
    fxtestbot help - Displays all of the help commands that fxtestbot knows about.
    fxtestbot ping - Reply with pong
    ...


## Testing fxtestbot

The unit tests can be run via the command line with the command:
```
npm test
```

## Deploying to Heroku

fxtestbot is deployed to Heroku. If you need to deploy a new instance of fxtestbot you will need to define
the following environment variables via the Heroku UI or command line client:

* HUBOT_BUGZILLA_URL - The url to the instance of Bugzilla that you use.
Current value: `https://bugzilla.mozilla.org`
* HUBOT_GITHUB_EVENT_NOTIFIER_ROOM - The name of the chat room in which you wish to notify GitHub events.
Current value: `#fx-test`
* HUBOT_GITHUB_EVENT_NOTIFIER_TYPES - The types of GitHub events about which you wish to be notified.
Current value: `issues, push, pull_request`
* HUBOT_IRC_NICK - The nick for the bot.
Current value: `fxtestbot`
* HUBOT_IRC_ROOMS - A list of rooms which you want the bot to join.
Current value: `#fx-test`
* HUBOT_IRC_SERVER - The IRC server to which you want the bot to connect.
Current value: `irc.mozilla.org`
* HUBOT_WELCOME_MESSAGE - The message to use to greet new people who join the channel.
Current value: `Hey {nick}, welcome to our channel! If you want to know more about our team, visit https://firefox-test-engineering.readthedocs.io/en/latest/`

You will also need to add a Redis add-on, such as [Heroku Redis][heroku-redis]

[heroku-redis]: [https://elements.heroku.com/addons/heroku-redis]

## Setting up GitHub Webhooks

A hook needs to be added to each GitHub repository about whose activity you wish fxtestbot to report.
To do this, go to the repository settings page in GitHub, choose *Webhooks & services*, then choose *Add a webhook*.
From the *Add webhook* page, specify `https://fxtestbot.herokuapp.com/hubot/gh-repo-events` as the *Payload URL*.
Be sure to also set the content-type to application/json.  Next, choose *Let me select individual events.* Choose the *Issues*, *Pull Request* and *Push* events.
Click the *Add webhook* button to save your new webhook.

## Contributing to the bot

The internal logic of the bot, for the most part, can be found in [`scripts/fxtest.coffee`](scripts/fxtest.coffee), so if you
want to make any changes or add any features, that is the best place to start.
You may also want to check out the [Hubot Scripting Guide][scripting-docs].

[scripting-docs]: https://hubot.github.com/docs/scripting/

The responses the bot uses are located in the [`resources/responses.properties`](resources/responses.properties) file.

Unit tests for the bot are located in the [`tests/test_fxtest.coffee`](tests/test_fxtest.coffee) file.  The ```context 'hubot responding to events'``` is where you add tests that test if the bot responds to [events](https://hubot.github.com/docs/scripting/#events) created by another script (such as [`cron-jobs.coffee`](scripts/cron-jobs.coffee)).  The ```context 'hubot responding to user messages'``` is where you add tests that test if the bot responds to messages sent by a user.  If your test does not fall under those two categories then please create a new context and add your test there.

### external-scripts

There will inevitably be functionality that everyone will want. Instead of
including this in fxtestbot's internal scripts, you can either create your own
external script, or use one that someone else has already created.

Hubot is able to load plugins from third-party `npm` packages. You can get a list of
available hubot plugins on [npmjs](https://www.npmjs.com/) or by using `npm search`:

    % npm search hubot-scripts panda
    NAME             DESCRIPTION                        AUTHOR DATE       VERSION KEYWORDS
    hubot-pandapanda a hubot script for panda responses =missu 2014-11-30 0.9.2   hubot hubot-scripts panda
    ...

To use a package, check the package's documentation, but in general it is:

1. Use `npm install --save` to add the package to `package.json` and install it.
2. Add the package name to `external-scripts.json` as a double quoted string.

Note: Please add your new package to the above files maintaining the alphabetical order of the packages.

You can review [`external-scripts.json`](external-scripts.json) to see what is currently used by fxtestbot.

[npmjs]: https://www.npmjs.com
