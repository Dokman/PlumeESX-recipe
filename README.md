# RenzuESX-recipe

[![Plume ESX Video Tutorial](https://i.imgur.com/jjUbS1Z.png)](https://www.youtube.com/watch?v=iGfwUCO0RZQ)

**Description:** A full featured and highly configurable yet lightweight ESX Legacy base that can be easily extended.  

**This Recipe is not runnning in TxAdmin you need to configure it manually**
Please check the [**Recipe Documentation Page**](https://github.com/tabarra/txAdmin/blob/master/docs/recipe.md).

**Please you may use [MySQL 5](https://dev.mysql.com/downloads/windows/installer/5.7.html) or [MariaDB](https://mariadb.org/), to improve performance with mysql-async**

## Requirements
- [FXServer](https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/) > 4878 build
- [MySQL 5](https://dev.mysql.com/downloads/windows/installer/5.7.html) or [MariaDB](https://mariadb.org/) to host the database of the server.
- [Node.JS(LTS)](https://nodejs.org/es/) used by [screenshot-basic](https://github.com/citizenfx/screenshot-basic)
 - [Yarn]() Install Command - `npm install --global yarn` used by [screenshot-basic](https://github.com/citizenfx/screenshot-basic)

## Changelog

### Additions
- [renzu_customs](https://github.com/renzuzu/renzu_customs)
  - [renzu_engine](https://github.com/renzuzu/renzu_engine)
  - [renzu_nitro](https://github.com/renzuzu/renzu_nitro)
  - [renzu_stancer](https://github.com/renzuzu/renzu_stancer)
- [renzu_garage](https://github.com/renzuzu/renzu_garage)
- [renzu_clothes](https://github.com/renzuzu/renzu_clothes)
- [renzu_hud](https://github.com/renzuzu/renzu_hud)
- [renzu_jobs](https://github.com/renzuzu/renzu_jobs)
- [renzu_lockgame](https://github.com/renzuzu/renzu_lockgame)
- **Renzu Dependencies**
  - [renzu_contextmenu](https://github.com/renzuzu/renzu_contextmenu)
  - [renzu_popui](https://github.com/renzuzu/renzu_popui)
  - [renzu_notify](https://github.com/renzuzu/renzu_notify)
  - [renzu_drawmarkerui](https://github.com/renzuzu/renzu_drawmerkerui)

### Based on PlumeESX
### v3.0.0
- Updated recipe to work with NEW ESX Legacy
- Added new multicharacter system
- Updated IPLs
- Update loading screen
- Optimised file structure
- Minimised server.cfg
- Added modern hud
- Added MDT (police Mobile Data Terminal)
- Added shotspotter
- Added pma-voice
- Added RP-Radio

### v2.1.0
- Removed `cd_easytime`;
- Fixed spawnpoint being inside the job listing marker;
- Fixed vehicle ownership issues (solves cars not saving in garage);
- Automatic admin for people that join the server for the first time with the `commands` ace permission.

## TODO:
- [ ] add linden inventory
