# WhereAmI

A simple Elixir command-line program that approximates the user's location and uploads it online to Gowiem/whereami.com.

The script is meant to run periodically via SleepWatcher and a MacOS LaunchAgent.

## Dependencies

1. Elixir -- `brew install elixir`
2. [SleepWatcher](http://www.bernhard-baehr.de/)

## Install

1. `mix deps.get`
2. `mix escript.build`
3. `cp ./where_am_i ~/.wakeup`
4. `cp com.gowie.whereami.plist ~/Library/LaunchAgents/com.gowie.whereami.plist`
5. `launchctl load ~/Library/LaunchAgents/com.gowie.whereami.plist`
