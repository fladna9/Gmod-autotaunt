# Garry's Mod Auto Taunt Addon project

[![Join the chat at https://gitter.im/fladna9/Gmod-autotaunt](https://badges.gitter.im/fladna9/Gmod-autotaunt.svg)](https://gitter.im/fladna9/Gmod-autotaunt?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
A Garry's Mod lua script that makes props auto taunt

As not any of these plugins where available on the Internet, decided to create it myself.
This is my first lua project, please be nice ;)

If you want to contribute/fork, don't hesitate :D


## How does it work
On player spawn, if player is a prop, it creates a timer that will sound a random taunt.

On player death, if player is a prop, it removes the timer.

It also prints a line in the server console for each prop auto taunting.


## How to use
Make sure your server has the following addons : 
* "Prop Hunt New Taunts" : http://steamcommunity.com/sharedfiles/filedetails/?id=272425836
* "Prop Hunt Tauntpack Loader" : http://steamcommunity.com/sharedfiles/filedetails/?id=272852615
* A Prop Hunt addon (tested on "Wolvin's: Enhanced Prop Hunt" : http://steamcommunity.com/sharedfiles/filedetails/?id=417565863 )

Create missing directories and copy *autotaunt.lua* in 
```
<dedicated server files>/garrysmod/addons/autotaunt/lua/autorun/autotaunt.lua
```
Restart your server and you're good to go.

## How to configure
This lua file has a settings part for you to easily edit the behaviour of the addon, without having to dig into the code.
```lua
-- Change here the time you want between 2 taunts
timeBetweenTwoTaunts = 60
-- Change here how many times you want this auto taunt be be executed in a round
howManyTimes = 5
-- The number of taunts available. Can find with ph_tauntlist in console
maxTaunts = 75
```

## Licence
This project is licensed under GNU/GPL v3. 
You can find a version of the license at http://www.gnu.org/licenses/gpl-3.0.en.html
