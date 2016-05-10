# Gmod-autotaunt project
A Garry's Mod lua script that makes props auto taunt every 1 minute

As not any of these plugins where available on the Internet, decided to create it myself.
This is my first lua project, be nice ;)

## How does it work
On player spawn, if player is a prop, it creates a timer that will sound the "This is Sparta" taunt every minute.
On player death, if player is a prop, it removes the timer.
It also prints a line in the console for each prop auto taunting.

## How to use
Create directories and copy autotaunt.lua in <dedicated server files>/garrysmod/addons/autotaunt/lua/autorun/autotaunt.lua
Restart your server and you're ok to go.

## Licence
This project is licensed under GNU/GPL v3
You can find a version of the license at http://www.gnu.org/licenses/gpl-3.0.en.html
